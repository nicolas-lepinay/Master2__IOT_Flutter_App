import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:arduino_iot_app/repository/users_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final UsersRepository userRepository;

  LoginCubit(this.userRepository) : super(LoginState.initial()) {
    debugPrint("LOGIN CUBIT - CONSTRUCTOR");
  }

  Future<void> login(String username, String password) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: () => null,
    ));
    try {
      final user = await userRepository.login(username, password);

      if (user != null) {
        // Connexion réussie
        emit(state.copyWith(
          isLoading: false,
          user: user,
        ));
      } else {
        // Identifiants invalides
        emit(state.copyWith(
          isLoading: false,
          errorMessage: () => "Les identifiants sont invalides.",
        ));
      }
    } catch (e) {
      // Erreur inconnue
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => "Une erreur inconnue est survenue.",
      ));
    }
  }

  // A la fermeture du cubit, annuler les abonnements aux streams
  @override
  Future<void> close() {
    //_subscriptions.dispose();
    return super.close();
  }
}

class LoginState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    this.user,
    required this.isLoading,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      isLoading: false,
    );
  }

  LoginState copyWith({
    User? user,
    bool? isLoading,
    String? Function()? errorMessage,
  }) {
    return LoginState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
