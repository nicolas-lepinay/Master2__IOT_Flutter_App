import 'package:flutter/material.dart';

import 'package:arduino_iot_app/utils/constants.dart';

class UIButtonLarge extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback callback;
  final bool isLoading;

  const UIButtonLarge({
    super.key,
    required this.label,
    this.color = Constants.tomato,
    required this.callback,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('key--${label.replaceAll(" ", "_")}'),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 60),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        shadowColor: color.withOpacity(0.5), // Couleur de l'ombre
      ),
      onPressed: callback,
      child: isLoading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 3),
            )
          : Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
    );
  }
}