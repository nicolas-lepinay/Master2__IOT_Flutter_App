import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipment {
  final String id;
  final String esp32Id;
  final String name;
  final bool state;
  final String? value;
  final String? unit;
  final String houseId;
  final String? roomId;

  Equipment({
    required this.id,
    required this.esp32Id,
    required this.name,
    required this.state,
    this.value,
    this.unit,
    required this.houseId,
    this.roomId,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);

  Equipment copyWith({
    String? id,
    String? esp32Id,
    String? name,
    bool? state,
    String? value,
    String? unit,
    String? houseId,
    String? roomId,
  }) {
    return Equipment(
      id: id ?? this.id,
      esp32Id: esp32Id ?? this.esp32Id,
      name: name ?? this.name,
      state: state ?? this.state,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      houseId: houseId ?? this.houseId,
      roomId: roomId ?? this.roomId,
    );
  }
}
