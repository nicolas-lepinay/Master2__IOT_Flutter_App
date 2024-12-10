import 'package:arduino_iot_app/data_source/global_data_source.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GlobalRepository {
  late final List<Future<void> Function()> futuresToWait;
  final GlobalDataSource dataSource;

  GlobalRepository(this.dataSource) {
    futuresToWait = [_fetchEquipments];
    //_init();
    _startPeriodicUpdates(); // Démarre les mises à jour périodiques
  }

  // Equipments
  final BehaviorSubject<List<Equipment>> _equipmentsController =
      BehaviorSubject<List<Equipment>>();

  // Stream getters
  Stream<List<Equipment>> get equipmentsStream => _equipmentsController.stream;

  Future<void> _init() async {
    try {
      await Future.wait(futuresToWait.map((f) => f()));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchEquipments() async {
    try {
      final newEquipments = await dataSource.getEquipments();
      final currentEquipments = _equipmentsController.valueOrNull ?? [];

      // Mettre à jour uniquement les équipements existants
      final updatedEquipments = currentEquipments.map((currentEquipment) {
        final matchingNewEquipment = newEquipments.firstWhere(
          (newEquipment) => newEquipment.id == currentEquipment.id,
          orElse: () => currentEquipment,
        );

        // Mettre à jour les champs uniquement si nécessaire
        return currentEquipment.copyWith(
          state: matchingNewEquipment.state,
          value: matchingNewEquipment.value,
        );
      }).toList();

      // Ajouter les nouveaux équipements qui ne sont pas encore dans la liste actuelle
      final missingEquipments = newEquipments.where((newEquipment) {
        return !currentEquipments.any((e) => e.id == newEquipment.id);
      }).toList();

      _equipmentsController.add([...updatedEquipments, ...missingEquipments]);
    } catch (e) {
      debugPrint('Erreur lors de la récupération des équipements : $e');
      rethrow;
    }
  }

  void _startPeriodicUpdates() {
    Stream.periodic(const Duration(seconds: 5)).listen((_) async {
      try {
        await _fetchEquipments();
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<void> updateEquipment(Equipment equipment) async {
    try {
      await dataSource.updateEquipment(equipment);
      //_fetchEquipments(); // Optionnel : recharger les équipements
    } catch (e) {
      rethrow;
    }
  }
}
