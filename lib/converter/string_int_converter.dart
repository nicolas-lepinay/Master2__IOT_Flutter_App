import 'package:json_annotation/json_annotation.dart';

class StringIntConverter implements JsonConverter<int, String> {
  const StringIntConverter();

  @override
  int fromJson(String json) => int.parse(json);

  @override
  String toJson(int value) => "$value";
}
