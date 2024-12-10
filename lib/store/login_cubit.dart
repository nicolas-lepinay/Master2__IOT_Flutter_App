import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:arduino_iot_app/repository/users_repository.dart';
import 'package:injectable/injectable.dart';

//TODO: UPDATE STATE TO BE ABLE TO EMIT NULL VALUES (ERROR MESSAGE)
/*
void updateBirthday(DateTime? birthday) {
  emit(state.copyWith(birthday: () => birthday));
}
*/

@singleton
class LoginCubit extends Cubit<LoginState> {
  final UsersRepository userRepository;

  LoginCubit(this.userRepository) : super(LoginState.initial());

  Future<void> login(String username, String password) async {
    emit(LoginState.initial());
    try {
      final user = await userRepository.login(username, password);

      if (user != null) {
        // Connexion réussie
        emit(state.copyWith(
          isLoading: false,
          user: user,
          errorMessage: null,
        ));
      } else {
        // Identifiants invalides
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Les identifiants sont invalides.",
        ));
      }
    } catch (e) {
      // Erreur inconnue
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Une erreur inconnue est survenue.",
      ));
    }
  }
}

class LoginState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    required this.user,
    required this.isLoading,
    required this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      user: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  LoginState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
