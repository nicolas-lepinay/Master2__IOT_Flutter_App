import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class H2 extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const H2({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.color = Constants.darkest,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
