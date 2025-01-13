import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/layout/animated_background.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/typography/h2.dart';
import 'package:arduino_iot_app/widgets/components/buttons/selectable_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/injection/get_it.dart';
import 'package:arduino_iot_app/store/users_selection_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:arduino_iot_app/repository/users_repository.dart';
import 'package:arduino_iot_app/widgets/components/buttons/ui_button.dart';

class UsersSelectionPage extends StatelessWidget {
  const UsersSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersSelectionCubit>(
      create: (context) => UsersSelectionCubit(getIt<UsersRepository>()),
      child: BlocConsumer<UsersSelectionCubit, UsersSelectionState>(
          listenWhen: (previous, current) {
        return previous.isSuccess == false && current.isSuccess == true;
      }, listener: (BuildContext context, UsersSelectionState state) {
        if (state.isSuccess) {
          context.go('/home');
        }
      }, builder: (context, state) {
        return AnimatedBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              children: [
                const H2(text: Constants.users_selection_title),
                const SizedBox(height: 60),
                Column(
                  children: List.generate(state.users.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SelectableCard(
                          user: state.users[index],
                          isSelected:
                              state.users.indexOf(state.selectedUser!) == index,
                          onTap: () => {
                                context
                                    .read<UsersSelectionCubit>()
                                    .selectUser(state.users[index])
                              }),
                    );
                  }),
                ),
                const Spacer(),
                UIButton(
                  label: 'Confirmer',
                  color: Constants.periwinkle,
                  isDisabled: state.selectedUser == null,
                  callback: () {
                    context.read<UsersSelectionCubit>().autoLogin();
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}
