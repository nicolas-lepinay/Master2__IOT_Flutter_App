import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/widgets/components/misc/data_value.dart';

class AnimatedCardContent extends StatelessWidget {
  final Equipment equipment;

  const AnimatedCardContent({
    required this.equipment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            //color: Constants.lilac.withOpacity(0.3),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(equipment.imageAssetPath),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                equipment.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Chip(
              label: equipment.state ? const Text('ON') : const Text('OFF'),
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: equipment.state ? Constants.darkest : Constants.lightest,
              ),
              backgroundColor: equipment.state
                  ? Constants.pickle.withOpacity(0.5)
                  : Constants.tomato,
              //backgroundColor: Constants.light,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.transparent),
              ),
              visualDensity: const VisualDensity(vertical: -2),
            ),
          ],
        ),
        const SizedBox(height: 5),
        DataValue(
          esp32Id: equipment.esp32Id,
          value: equipment.value,
          unit: equipment.unit,
        ),
      ],
    );
  }
}
