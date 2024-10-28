import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(2024);

  void increment() {
    if (state < 2030) {
      emit(state + 1);
    }
  }

  void decrement() {
    if (state > 2020) {
      emit(state - 1);
    }
  }

  void logState() {
    debugPrint("VALEUR DU STATE : $state");
  }
}
