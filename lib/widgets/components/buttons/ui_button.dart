import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/buttons/ui_button_large.dart';
import 'package:arduino_iot_app/widgets/components/buttons/ui_button_small.dart';

class UIButton extends StatelessWidget {
  final String size;
  final String label;
  final Color color;
  final VoidCallback callback;
  final bool isLoading;

  const UIButton({
    super.key,
    this.size = 'large',
    required this.label,
    this.color = Constants.tomato,
    required this.callback,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return size == 'small'
        ? UIButtonSmall(
            label: label,
            color: color,
            callback: callback,
            isLoading: isLoading,
          )
        : UIButtonLarge(
            label: label,
            color: color,
            callback: callback,
            isLoading: isLoading,
          );
  }
}
