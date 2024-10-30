import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class Caption extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const Caption({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.color = Constants.darkest,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
