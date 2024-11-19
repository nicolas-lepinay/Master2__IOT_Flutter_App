import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/equipment.dart';
import 'package:arduino_iot_app/repository/global_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arduino_iot_app/services/mqtt_client.dart';

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
