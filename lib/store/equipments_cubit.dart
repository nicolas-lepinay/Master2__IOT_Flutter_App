import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/repository/equipments_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arduino_iot_app/services/mqtt_client.dart';
import 'package:arduino_iot_app/models/exceptions/apiException.dart';
import 'package:arduino_iot_app/utils/toast_helper.dart';
import 'package:arduino_iot_app/utils/constants.dart';

@singleton
class EquipmentsCubit extends Cubit<EquipmentsState> {
  final EquipmentsRepository repository;
  final MQTT mqtt;
  final _subscriptions = CompositeSubscription();

  EquipmentsCubit(this.repository, this.mqtt)
      : super(EquipmentsState.initial()) {
    _subscribe();
  }

  // Map pour définir quels équipements afficher par onglet
  final Map<int, List<String>> _tabFilters = {
    0: [
      'LED',
      'RGB_LED',
      'FAN',
      'LCD_DISPLAY',
      'BUZZER',
      'WINDOW_SERVO',
      'DOOR_SERVO',
    ],
    1: [
      'TEMP_SENSOR',
      'HUMIDITY_SENSOR',
      'GAS_SENSOR',
      'STEAM_SENSOR',
      'MOTION_SENSOR',
    ],
  };

  void _subscribe() {
    repository.equipmentsStream.listen((equipments) {
      emit(state.copyWith(equipments: equipments));
      _filterEquipments(state.currentTab);
    }).addTo(_subscriptions);
    emit(state.copyWith(isLoading: false));
  }

  void _filterEquipments(int tab) {
    final filteredItems = state.equipments.where((e) {
      return _tabFilters[tab]?.contains(e.esp32Id) ?? false;
    }).toList();
    emit(state.copyWith(filteredEquipments: filteredItems, currentTab: tab));
  }

  void _updateEquipmentLocally({
    required Equipment oldItem,
    required Equipment newItem,
  }) {
    emit(state.copyWith(
      equipments: state.equipments.map((e) {
        return e.id == oldItem.id ? newItem : e;
      }).toList(),
    ));
  }

  Future<void> _updateEquipment({
    required Equipment oldItem,
    required Equipment newItem,
  }) async {
    try {
      // 1️⃣ Changer l'objet local
      _updateEquipmentLocally(oldItem: oldItem, newItem: newItem);
      // 2️⃣ Mettre à jour l'objet en base de données
      await repository.updateEquipment(newItem);
    } on ApiException catch (e) {
      // 3️⃣ En cas d'erreur, reset l'objet local
      _updateEquipmentLocally(oldItem: oldItem, newItem: oldItem);
      _toastError('Oops ! Une erreur est survenue (${e.statusCode})');
    } catch (e) {
      // 3️⃣
      _updateEquipmentLocally(oldItem: oldItem, newItem: oldItem);
      _toastError('Aïe ! Une erreur inconnue est survenue.');
    } finally {
      _filterEquipments(state.currentTab);
    }
  }

  void _toastError(String msg) {
    ToastHelper.toast(msg, backgroundColor: Constants.tomato.withOpacity(0.9));
  }

  void _toastSuccess(String msg) {
    ToastHelper.toast(' $msg ');
  }

  void changeTab(int tab) {
    _filterEquipments(tab);
    emit(state.copyWith(currentIndex: 0, currentTab: tab));
  }

  void updateIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<void> toggleEquipmentState(Equipment equipment) async {
    final updatedState = !equipment.state;
    final updatedEquipment = equipment.copyWith(state: updatedState);

    // Publier le message MQTT approprié
    final topic = 'SET/${equipment.esp32Id}';
    final payload =
        updatedState ? (equipment.value ?? "") : '${equipment.defaultOffValue}';

    // Mettre à jour l'équipement et publier le message
    await _updateEquipment(oldItem: equipment, newItem: updatedEquipment);

    // Publier le message MQTT après la mise à jour
    mqtt.publishMessage(topic, payload);
  }

  Future<void> updateEquipmentValue({
    required Equipment equipment,
    required String value,
  }) async {
    final updatedEquipment = equipment.copyWith(value: value);
    _updateEquipment(oldItem: equipment, newItem: updatedEquipment);
    _toastSuccess("L'équipement a été mis à jour.");
  }

  // A la fermeture du cubit, annuler les abonnements aux streams
  @override
  Future<void> close() {
    _subscriptions.dispose();
    return super.close();
  }
}

class EquipmentsState {
  final List<Equipment> equipments;
  final List<Equipment> filteredEquipments;
  final bool isLoading;
  final int currentTab;
  final int currentIndex;

  EquipmentsState({
    required this.equipments,
    required this.filteredEquipments,
    required this.isLoading,
    required this.currentTab,
    required this.currentIndex,
  });

  factory EquipmentsState.initial() {
    return EquipmentsState(
      equipments: [],
      filteredEquipments: [],
      isLoading: true,
      currentTab: 0,
      currentIndex: 0,
    );
  }

  EquipmentsState copyWith({
    List<Equipment>? equipments,
    List<Equipment>? filteredEquipments,
    bool? isLoading,
    int? currentTab,
    int? currentIndex,
  }) =>
      EquipmentsState(
        equipments: equipments ?? this.equipments,
        filteredEquipments: filteredEquipments ?? this.filteredEquipments,
        isLoading: isLoading ?? this.isLoading,
        currentTab: currentTab ?? this.currentTab,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
