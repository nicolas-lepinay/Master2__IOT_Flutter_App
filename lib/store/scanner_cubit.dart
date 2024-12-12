import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:arduino_iot_app/repository/users_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arduino_iot_app/utils/toast_helper.dart';
import 'package:arduino_iot_app/utils/constants.dart';

@injectable
class ScannerCubit extends Cubit<ScannerState> {
  final UsersRepository userRepository;
  //final _subscriptions = CompositeSubscription();

  ScannerCubit(this.userRepository) : super(ScannerState.initial()) {
    //_subscribe();
    debugPrint("CONSTRUCTOR SCANNER CUBIT");
  }

  void _subscribe() {
    debugPrint("SUBSCRIBE SCANNER CUBIT");
    /*
    userRepository.userStream.listen((user) {
      emit(state.copyWith(user: user));
    }).addTo(_subscriptions);
     */
  }

  Future<void> onQRCodeScanned(String qrCode) async {
    emit(state.copyWith(isLoading: true));
    final List<User> users = await userRepository.getUsersByHouse(qrCode);
    emit(state.copyWith(users: users, isLoading: false));
    if (users.isEmpty) {
      ToastHelper.toast(
        " Aucun utilisateur n'a été trouvé 😔 ",
        backgroundColor: Constants.darker,
      );
    }
  }

  // A la fermeture du cubit, annuler les abonnements aux streams
  @override
  Future<void> close() {
    //_subscriptions.dispose();
    return super.close();
  }
}

class ScannerState {
  final List<User> users;
  final bool isLoading;

  ScannerState({
    required this.users,
    required this.isLoading,
  });

  factory ScannerState.initial() {
    return ScannerState(
      users: [],
      isLoading: false,
    );
  }

  ScannerState copyWith({
    List<User>? users,
    bool? isLoading,
  }) {
    return ScannerState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
