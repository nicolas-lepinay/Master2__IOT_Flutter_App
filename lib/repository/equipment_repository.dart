import 'package:arduino_iot_app/data_source/equipments_data_source.dart';
import 'package:arduino_iot_app/models/equipment.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EquipmentRepository {
  final EquipmentDataSource dataSource;

  EquipmentRepository(this.dataSource);

  Future<List<Equipment>> fetchEquipments() {
    return dataSource.getEquipments();
  }
}
