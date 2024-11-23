import 'package:arduino_iot_app/data_source/global_data_source.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:rxdart/rxdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GlobalRepository {
  late final List<Future<void> Function()> futuresToWait;
  final GlobalDataSource dataSource;

  GlobalRepository(this.dataSource) {
    futuresToWait = [_fetchEquipments];
    _init();
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

  Future<List<Equipment>> _fetchEquipments() async {
    try {
      List<Equipment> equipments = await dataSource.getEquipments();
      _equipmentsController.add(equipments);
      return equipments;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEquipmentState(Equipment equipment) async {
    try {
      await dataSource.updateEquipment(equipment);
      //_fetchEquipments(); // Optionnel : recharger les équipements
    } catch (e) {
      rethrow;
    }
  }
}
