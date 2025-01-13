import 'package:arduino_iot_app/data_source/users_data_source.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class UsersRepository {
  final UsersDataSource dataSource;

  UsersRepository(this.dataSource);

  // Logged-in user
  User? _user;
  User? get user => _user;
  final BehaviorSubject<User?> _userController = BehaviorSubject<User?>();

  // House Users
  final List<User> _houseUsers = [];
  List<User> get houseUsers => _houseUsers;
  //final BehaviorSubject<List<User>> _houseUsersController = BehaviorSubject<List<User>>();

  // Stream getters
  Stream<User?> get userStream => _userController.stream;
  //Stream<List<User>> get houseUsersStream => _houseUsersController.stream;

  Future<User?> login(String username, String password) async {
    try {
      final user = await dataSource.login(username, password);
      if (user != null) {
        _user = user;
        _userController.add(user);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  void autoLogin(User user) async {
    _user = user;
    _userController.add(user);
  }

  void logout() {
    _user = null;
    _userController.add(null);
  }

  Future<List<User>> getUsersByHouse(String houseId) async {
    try {
      final users = await dataSource.getUsersByHouse(houseId);
      if (users.isNotEmpty) {
        _houseUsers.clear();
        _houseUsers.addAll(users);
        //_houseUsersController.addAll(users);
      }
      return users;
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
