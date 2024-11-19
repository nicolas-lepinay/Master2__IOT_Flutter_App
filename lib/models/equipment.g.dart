// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      json[r'$id'] as String,
      json['name'] as String,
      json['state'] as bool,
      json['value'] as String?,
      json[r'$updatedAt'] as String,
      json['icon'] as String?,
      json['house_id'] as String,
      json['room_id'] as String?,
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      r'$id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'value': instance.value,
      r'$updatedAt': instance.updatedAt,
      'icon': instance.icon,
      'house_id': instance.houseId,
      'room_id': instance.roomId,
    };
