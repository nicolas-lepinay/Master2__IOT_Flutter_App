import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class RoundAvatarButton extends StatelessWidget {
  final String avatar;
  final VoidCallback callback;
  final double radius;

  const RoundAvatarButton({
    super.key,
    required this.avatar,
    required this.callback,
    this.radius = 26,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      //backgroundColor: Constants.darkGrey.withOpacity(0.3),
      backgroundColor: Constants.lightGrey,
      radius: radius,
      child: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
        //backgroundColor: Constants.lightestGrey,
        backgroundColor: Constants.lightGrey,
        radius: radius - 1,
      ),
    );
  }
}
