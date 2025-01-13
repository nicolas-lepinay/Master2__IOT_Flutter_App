import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/typography/h3.dart';
import 'package:arduino_iot_app/widgets/components/buttons/round_icon_button.dart';
import 'package:arduino_iot_app/widgets/components/buttons/round_avatar_button.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../store/equipments_cubit.dart';

class AppBarActions extends StatelessWidget {
  final User? user;

  const AppBarActions({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RoundAvatarButton(
          avatar: user?.avatar ?? '',
          callback: () {},
        ),
        const SizedBox(width: 10),
        Expanded(
          child: H3(
            text: 'Bonjour, ${user?.username}',
            textAlign: TextAlign.left,
          ),
        ),
        /*
        RoundIconButton(
          icon: Constants.searchIcon,
          callback: () {},
        ),
         */
        const SizedBox(width: 20),
        RoundIconButton(
          icon: Constants.offIcon,
          callback: () {
            context.read<EquipmentsCubit>().logout();
            context.go('/');
          },
        ),
      ],
    );
  }
}
