import 'package:arduino_iot_app/data_source/global_data_source.dart';
import 'package:arduino_iot_app/models/equipment.dart';
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
  List<Equipment> _equipmentsData = [];
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

  Future<List<Equipment>> fetchEquipments() {
    return dataSource.getEquipments();
  }

  void _fetchEquipments() async {
    var response = await dataSource.getEquipments_v2();
    return;
  }


}
