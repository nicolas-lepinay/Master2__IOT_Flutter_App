import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/typography/text_body.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class Localization extends StatelessWidget {
  final String location;

  const Localization({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_pin,
          size: 20,
          color: Constants.periwinkle,
        ),
        const SizedBox(width: 5.0),
        Caption(
          text: location,
          color: Constants.periwinkle,
        ),
      ],
    );
  }
}
