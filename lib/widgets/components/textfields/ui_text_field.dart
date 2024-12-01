import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class UITextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool? isPassword;

  const UITextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Constants.white.withOpacity(0.7),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Constants.neutral,
          fontWeight: FontWeight.w100,
        ),
      ),
      obscureText: isPassword ?? false,
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.top + 50,
      ),
    );
  }
}
