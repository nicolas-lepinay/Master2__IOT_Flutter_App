import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/typography/text_body.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class Localization extends StatelessWidget {
  const Localization({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.location_pin,
          size: 20,
          color: Constants.periwinkle,
        ),
        SizedBox(width: 5.0),
        Caption(
          text: 'Pertuis, France',
          color: Constants.periwinkle,
        ),
      ],
    );
  }
}
