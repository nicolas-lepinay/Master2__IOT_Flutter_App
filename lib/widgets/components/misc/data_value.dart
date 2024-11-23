import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class DataValue extends StatelessWidget {
  final String esp32Id;
  final String? value;
  final String? unit;

  const DataValue({
    super.key,
    required this.esp32Id,
    this.value,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final icon = getIconFromEquipment(esp32Id);

    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Constants.periwinkle,
        ),
        const SizedBox(width: 7.0),
        Caption(
          text: (value != null && unit != null)
              ? '$value $unit'
              : 'Aucune donnée.',
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
