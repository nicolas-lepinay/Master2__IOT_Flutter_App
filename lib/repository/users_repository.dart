import 'package:arduino_iot_app/data_source/users_data_source.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UsersRepository {
  final UsersDataSource dataSource;

  UsersRepository(this.dataSource);

  User? _user;
  User? get user => _user;

  Future<User?> login(String username, String password) async {
    try {
      final user = await dataSource.login(username, password);
      if (user != null) {
        _user = user;
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getUsersByHouse(String houseId) async {
    try {
      return await dataSource.getUsersByHouse(houseId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setUserById(String userId) async {
    try {
      final user = await dataSource.getUserById(userId);
      _user = user; // Met à jour l'utilisateur connecté
    } catch (e) {
      debugPrint('Failed to set user by ID: $e');
      rethrow;
    }
  }
}
