import 'package:flutter/material.dart';

import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/store/equipments_cubit.dart';
import 'animated_card_content.dart';

class AnimatedCard extends StatelessWidget {
  // Position initiale (true pour la position 1, false pour la position 2)
  // final bool initialPosition;

  // Callback pour l'appel d'API au double-tap
  final bool Function() onDoubleTap;
  final Equipment equipment;
  final double ratio;

  const AnimatedCard({
    super.key,
    //required this.initialPosition,
    required this.onDoubleTap,
    required this.equipment,
    this.ratio = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - (70 * 2);
    return GestureDetector(
      onDoubleTap: () =>
          context.read<EquipmentsCubit>().toggleEquipmentState(equipment),
      child: Center(
        child: Opacity(
          opacity: equipment.state ? 1 : 0.6,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Conteneur vert (arrière-plan)
              Container(
                //width: width,
                //height: width * ratio,
                width: width,
                height: width * ratio,
                decoration: BoxDecoration(
                  //color: Colors.purple.withOpacity(0.3),
                  color: equipment.state
                      ? Constants.pickle.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: equipment.state
                          ? Constants.pickle.withOpacity(0.8)
                          : Colors.transparent,
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              // Conteneur blanc (carte au-dessus)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedRotation(
                  turns: equipment.state ? -0.025 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: width,
                    height: width * ratio,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: equipment.state
                          ? Constants.lightest
                          : Constants.lightest.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: equipment.state
                              ? Constants.darkest.withOpacity(0.15)
                              : Colors.transparent,
                          blurRadius: 10,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: AnimatedCardContent(
                      equipment: equipment,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
