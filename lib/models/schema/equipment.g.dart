// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      id: json['id'] as String,
      esp32Id: json['esp32Id'] as String,
      name: json['name'] as String,
      state: json['state'] as bool,
      value: json['value'] as String?,
      unit: json['unit'] as String?,
      houseId: json['houseId'] as String,
      roomId: json['roomId'] as String?,
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'id': instance.id,
      'esp32Id': instance.esp32Id,
      'name': instance.name,
      'state': instance.state,
      'value': instance.value,
      'unit': instance.unit,
      'houseId': instance.houseId,
      'roomId': instance.roomId,
    };
