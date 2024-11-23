import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/repository/global_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arduino_iot_app/services/mqtt_client.dart';
import 'package:arduino_iot_app/models/exceptions/apiException.dart';
import 'package:arduino_iot_app/utils/toast_helper.dart';

import '../utils/constants.dart';

@lazySingleton
class EquipmentsCubit extends Cubit<EquipmentsState> {
  final GlobalRepository repository;
  final MQTT mqtt;
  final _subscriptions = CompositeSubscription();

  EquipmentsCubit(this.repository, this.mqtt)
      : super(EquipmentsState.initial()) {
    _subscribe();
  }

  void _subscribe() {
    repository.equipmentsStream.listen((equipments) {
      emit(state.copyWith(equipments: equipments));
    }).addTo(_subscriptions);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> toggleEquipmentState(Equipment equipment) async {
    try {
      // 1️⃣ Changer le STATE local
      final updatedEquipment = equipment.copyWith(state: !equipment.state);
      emit(state.copyWith(
        equipments: state.equipments.map((e) {
          return e.id == equipment.id ? updatedEquipment : e;
        }).toList(),
      ));
      // 2️⃣ Mettre à jour l'objet en base de données
      await repository.updateEquipmentState(updatedEquipment);
      // 3️⃣ En cas d'erreur, reset le STATE local
    } on ApiException catch (e) {
      ToastHelper.toast(
        'Oops ! Une erreur est survenue (${e.statusCode})',
        backgroundColor: Constants.tomato.withOpacity(0.9),
      );
      emit(state.copyWith(
        equipments: state.equipments.map((e) {
          return e.id == equipment.id ? equipment : e;
        }).toList(),
      ));
    } catch (e) {
      ToastHelper.toast(
        'Aïe ! Une erreur inconnue est survenue.',
        backgroundColor: Constants.tomato.withOpacity(0.9),
      );
      emit(state.copyWith(
        equipments: state.equipments.map((e) {
          return e.id == equipment.id ? equipment : e;
        }).toList(),
      ));
    }
  }
}

class EquipmentsState {
  final List<Equipment> equipments;
  final bool isLoading;

  EquipmentsState({
    required this.equipments,
    required this.isLoading,
  });

  factory EquipmentsState.initial() {
    return EquipmentsState(
      equipments: [],
      isLoading: true,
    );
  }

  EquipmentsState copyWith({
    List<Equipment>? equipments,
    bool? isLoading,
  }) =>
      EquipmentsState(
        equipments: equipments ?? this.equipments,
        isLoading: isLoading ?? this.isLoading,
      );
}
