import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/misc/localization.dart';
import 'package:arduino_iot_app/models/equipment.dart';

class AnimatedCardContent extends StatelessWidget {
  final Equipment equipment;

  const AnimatedCardContent({
    required this.equipment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String image = "assets/images/led-3d.webp";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.width / 3,
          decoration: const BoxDecoration(
            //color: Constants.lilac.withOpacity(0.3),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(image),
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
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Constants.darkest,
              ),
              backgroundColor: Constants.pickle.withOpacity(0.5),
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
        const Localization(location: 'Jardin'),
      ],
    );
  }
}
