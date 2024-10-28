import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class Heading1 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const Heading1({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: const TextStyle(
        color: Constants.eggplant,
        fontSize: 30,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
