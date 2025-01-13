import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class SelectableCard extends StatelessWidget {
  final User user;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCard({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Constants.white.withOpacity(0.4),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Constants.periwinkle : Constants.lighter,
            width: isSelected ? 2 : 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Image.asset(user.avatar, width: 80, height: 80),
              const SizedBox(width: 20),
              Text(
                user.username,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Constants.periwinkle : Constants.dark,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
