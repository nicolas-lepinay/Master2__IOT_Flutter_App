import 'package:flutter/material.dart';

import 'package:arduino_iot_app/utils/constants.dart';

class UIButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final bool? isLoading;

  const UIButton({
    super.key,
    required this.label,
    required this.callback,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('key--${label.replaceAll(" ", "_")}'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.tomato,
        minimumSize: const Size(double.infinity, 60),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        shadowColor: Constants.tomato.withOpacity(0.5), // Couleur de l'ombre
      ),
      onPressed: callback,
      child: isLoading ?? false
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
