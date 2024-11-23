import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/utils/settings.dart';
import 'package:injectable/injectable.dart';
import 'package:arduino_iot_app/models/exceptions/apiException.dart';

@lazySingleton
class GlobalDataSource {
  Future<List<Equipment>> getEquipments() async {
    try {
      final response = await http.get(Uri.parse(
          '${Settings.API_URL}/${Settings.EQUIPMENTS_ENDPOINT}/house/${Settings.HOUSE_ID}'));

      if (response.statusCode != 200) {
        throw ('Impossible de récupérer les équipements.');
      }

      final List<dynamic> jsonData = json.decode(response.body);
      final equipments = jsonData
          .map((doc) => Equipment.fromJson(doc as Map<String, dynamic>))
          .toList();
      return equipments;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> updateEquipment(Equipment equipment) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${Settings.API_URL}/${Settings.EQUIPMENTS_ENDPOINT}/${equipment.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(equipment.toJson()),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          "Impossible de mettre à jour l'équipement.",
          response.statusCode,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(
            'Erreur lors de la mise à jour de l\'équipement : ${e.toString()}');
      }
    }
  }
}
