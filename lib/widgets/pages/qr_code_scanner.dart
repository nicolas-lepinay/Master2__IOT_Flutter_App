import 'package:flutter/material.dart';
import 'package:arduino_iot_app/injection/get_it.dart';
import 'package:arduino_iot_app/store/scanner_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class QRCodeScanner extends StatelessWidget {
  final MobileScannerController _cameraController = MobileScannerController();
  bool isProcessingScan = false;

  QRCodeScanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScannerCubit>(
      create: (context) => getIt<ScannerCubit>(),
      child: BlocConsumer<ScannerCubit, ScannerState>(
        listenWhen: (previous, current) {
          // Écoute uniquement si users passe de vide à non-vide
          return previous.users.isEmpty || current.users.isNotEmpty;
        },
        listener: (BuildContext context, ScannerState state) {
          if (state.users.isNotEmpty) {
            debugPrint('************ USERS  FULL ************');
          } else {
            debugPrint('------------ USERS  VIDE ------------');
            context.go('/');
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                MobileScanner(
                  controller: _cameraController,
                  onDetect: (capture) async {
                    if (isProcessingScan) return;
                    // Définir le flag pour empêcher d'autres scans
                    isProcessingScan = true;
                    final List<Barcode> barcodes = capture.barcodes;
                    final String? qrCode = barcodes[0].rawValue;
                    if (qrCode == null) {
                      isProcessingScan = false;
                      return;
                    }
                    // Fermeture du controller pour éviter les scans doublons
                    // Voir issue : https://github.com/juliansteenbakker/mobile_scanner/issues/510
                    _cameraController.dispose();
                    // Réinitialiser le flag après le traitement du scan
                    isProcessingScan = false;
                    debugPrint("CODE QR : $qrCode");
                    context.read<ScannerCubit>().onQRCodeScanned(qrCode);
                    //context.pop(qrCode);
                  },
                ),
                if (state.isLoading)
                  Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Allumer/éteindre la torche
                _cameraController.toggleTorch();
              },
              backgroundColor: Constants.tomato,
              foregroundColor: Constants.white,
              child: const Icon(Icons.flashlight_on),
            ),
          );
        },
      ),
    );
  }
}
