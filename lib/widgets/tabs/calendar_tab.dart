import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/cubits/counter_cubit.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(builder: (contex, state) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("CALENDRIER DE L'ANNÉE :"),
            Text(
              '$state',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      );
    });
  }
}
