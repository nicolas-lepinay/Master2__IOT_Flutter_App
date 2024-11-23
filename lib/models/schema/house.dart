import 'package:json_annotation/json_annotation.dart';

part 'house.g.dart';

@JsonSerializable()
class House {
  final String id;
  final String esp32Id;
  final String name;

  House(
    this.id,
    this.esp32Id,
    this.name,
  );

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  Map<String, dynamic> toJson() => _$HouseToJson(this);
}
