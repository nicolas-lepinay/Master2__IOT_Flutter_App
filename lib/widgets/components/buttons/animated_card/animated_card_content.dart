import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/misc/localization.dart';

class AnimatedCardContent extends StatelessWidget {
  const AnimatedCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    const String image = "assets/images/led-3d.webp";
    const String name = "LED Jaune";

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
            const Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Chip(
              label: Text('ON'),
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
