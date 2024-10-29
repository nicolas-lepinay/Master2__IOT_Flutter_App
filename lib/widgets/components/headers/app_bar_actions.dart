import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/typography/h3.dart';
import 'package:arduino_iot_app/widgets/components/buttons/round_icon_button.dart';
import 'package:arduino_iot_app/widgets/components/buttons/round_avatar_button.dart';

class AppBarActions extends StatelessWidget {
  final IMAGE_URL =
      'https://rodrigovarejao.com/wp-content/uploads/2020/03/80abc9bceb94535ef1e24cce7e5efb8e-sticker.png';
  final WELCOME = 'Bonjour, Nicolas';

  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            RoundAvatarButton(
              avatar: IMAGE_URL,
              callback: () {},
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: H3(
            text: WELCOME,
            textAlign: TextAlign.left,
          ),
        ),
        RoundIconButton(
          icon: Constants.searchIcon,
          callback: () {},
        ),
        const SizedBox(width: 10),
        RoundIconButton(
          icon: Constants.notificationsIcon,
          callback: () {},
        ),
      ],
    );
  }
}
