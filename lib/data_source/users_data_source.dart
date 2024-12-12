import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:arduino_iot_app/utils/settings.dart';
import 'package:injectable/injectable.dart';
import 'package:arduino_iot_app/models/exceptions/apiException.dart';

import 'package:arduino_iot_app/models/schema/user.dart';

@lazySingleton
class UsersDataSource {
  Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Settings.API_URL}/${Settings.USERS_ENDPOINT}/${Settings.LOGIN_ENDPOINT}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final userJson = jsonDecode(response.body);
        return User.fromJson(userJson);
      } else if (response.statusCode == 401) {
        debugPrint("L'identification a échouée : identifiants invalides.");
        return null;
      } else {
        throw ApiException('Erreur inconnue.', response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getUsersByHouse(String houseId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Settings.API_URL}/${Settings.USERS_ENDPOINT}/house/$houseId'));

      if (response.statusCode != 200) {
        throw ApiException(
          "Impossible de récupérer les utilisateurs de la maison ‘$houseId’.",
          response.statusCode,
        );
      }
      final List<dynamic> jsonData = json.decode(response.body);
      final users = jsonData
          .map((doc) => User.fromJson(doc as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      final response = await http.get(
          Uri.parse('${Settings.API_URL}/${Settings.USERS_ENDPOINT}/$userId'));
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }
}
