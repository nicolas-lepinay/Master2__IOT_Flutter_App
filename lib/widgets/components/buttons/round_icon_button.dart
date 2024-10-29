import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class RoundIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback callback;
  final double radius;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.callback,
    this.radius = 26.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.white.withOpacity(1.0),
              width: 2.5,
            ),
          ),
          padding: const EdgeInsets.all(0.0),
          // !important
          backgroundColor: Constants.lightGrey,
          foregroundColor: Constants.lightGrey,
        ),
        child: Image.asset(
          icon,
          width: radius + (radius / 10), // Largeur de l'image
          height: radius + (radius / 10), // Hauteur de l'image
        ),
      ),
    );
  }
}
