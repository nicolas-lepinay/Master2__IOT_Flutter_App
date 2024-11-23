import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'constants.dart';

extension EquipmentAssetExtension on Equipment {
  EquipmentAsset get equipmentAsset {
    switch (esp32Id) {
      case 'LED':
        return EquipmentAsset.led;
      case 'FAN':
        return EquipmentAsset.fan;
      case 'LCD_DISPLAY':
        return EquipmentAsset.lcdDisplay;
      case 'TEMP_SENSOR':
        return EquipmentAsset.temperatureSensor;
      case 'HUMIDITY_SENSOR':
        return EquipmentAsset.humiditySensor;
      case 'GAS_SENSOR':
        return EquipmentAsset.gasSensor;
      default:
        return EquipmentAsset.unknown;
    }
  }

  String get imageAssetPath {
    return equipmentAsset.assetPath;
  }
}
