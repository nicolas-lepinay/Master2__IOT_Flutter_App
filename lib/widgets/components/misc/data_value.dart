import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';

class DataValue extends StatelessWidget {
  final Equipment equipment;

  const DataValue({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          equipment.dataIcon,
          size: 24,
          color: Constants.periwinkle,
        ),
        const SizedBox(width: 7.0),
        Caption(
          text:
              '${equipment.formatedValue ?? 'Aucune donnée'} ${equipment.unit ?? ''}',
          color: Constants.periwinkle,
        ),
      ],
    );
  }
}

IconData getIconFromEquipment(String esp32Id) {
  switch (esp32Id) {
    case 'LED':
      return Icons.lightbulb;
    case 'FAN':
      return Icons.wind_power;
    case 'LCD_DISPLAY':
      return Icons.tv;
    case 'TEMP_SENSOR':
      return Icons.thermostat;
    case 'HUMIDITY_SENSOR':
      return Icons.water_drop;
    case 'GAS_SENSOR':
      return Icons.gas_meter;
    default:
      return Icons.code_off;
  }
}
