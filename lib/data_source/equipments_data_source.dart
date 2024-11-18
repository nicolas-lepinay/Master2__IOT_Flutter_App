import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:arduino_iot_app/models/equipment.dart';
import 'package:arduino_iot_app/utils/settings.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EquipmentDataSource {
  Future<List<Equipment>> getEquipments() async {
    try {
      final response = await http
          .get(Uri.parse('${Settings.API_URL}${Settings.EQUIPMENTS_ENDPOINT}'));
      final jsonData = json.decode(response.body);
      final List<dynamic> documents = jsonData['documents'];
      final equipments = documents
          .map((doc) => Equipment.fromJson(doc as Map<String, dynamic>))
          .toList();
      return equipments;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
