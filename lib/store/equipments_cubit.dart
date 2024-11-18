import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/equipment.dart';
import 'package:arduino_iot_app/repository/equipment_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EquipmentsCubit extends Cubit<EquipmentsState> {
  final EquipmentRepository equipmentRepository;

  EquipmentsCubit(this.equipmentRepository) : super(EquipmentsState.initial()) {
    _fetchEquipments();
  }

  Future<void> _fetchEquipments() async {
    debugPrint("FETCHING EQUIPMENTS (AUTO)");
    try {
      //emit(EquipmentLoading());
      final equipments = await equipmentRepository.fetchEquipments();
      emit(state.copyWith(equipments: equipments));
      //emit(EquipmentLoaded(equipments));
    } catch (e) {
      //emit(EquipmentError('Failed to fetch equipments'));
    }
  }

  void fetchEquipments() async {
    _fetchEquipments();
  }
}

class EquipmentsState {
  final List<Equipment> equipments;

  EquipmentsState({required this.equipments});

  factory EquipmentsState.initial() {
    return EquipmentsState(equipments: []);
  }

  EquipmentsState copyWith({
    List<Equipment>? equipments,
  }) =>
      EquipmentsState(equipments: equipments ?? this.equipments);
}
