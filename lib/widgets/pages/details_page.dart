import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/layout/animated_background.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/widgets/components/typography/h2.dart';

import '../../utils/constants.dart';

class DetailsPage extends StatelessWidget {
  final Equipment equipment;
  const DetailsPage({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Constants.lightest.withOpacity(0.4),
        child: Center(
          child: H2(text: equipment.name),
        ),
      ),
    );
  }
}
