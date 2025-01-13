import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/user.dart';
import 'package:arduino_iot_app/repository/users_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersSelectionCubit extends Cubit<UsersSelectionState> {
  final UsersRepository userRepository;

  UsersSelectionCubit(this.userRepository)
      : super(UsersSelectionState.initial()) {
    _init();
  }

  void _init() {
    emit(state.copyWith(
      users: userRepository.houseUsers,
      selectedUser: userRepository.houseUsers[0],
    ));
  }

  void selectUser(User user) {
    emit(state.copyWith(selectedUser: user));
  }

  void autoLogin() {
    if (state.selectedUser != null) {
      userRepository.autoLogin(state.selectedUser!);
      emit(state.copyWith(isSuccess: true));
    }
  }

  // A la fermeture du cubit:
  @override
  Future<void> close() {
    emit(UsersSelectionState.initial());
    return super.close();
  }
}

class UsersSelectionState {
  final List<User> users;
  User? selectedUser;
  bool isSuccess;

  UsersSelectionState({
    required this.users,
    required this.isSuccess,
    this.selectedUser,
  });

  factory UsersSelectionState.initial() {
    return UsersSelectionState(
      users: [],
      isSuccess: false,
      selectedUser: null,
    );
  }

  UsersSelectionState copyWith({
    List<User>? users,
    User? selectedUser,
    bool? isSuccess,
  }) {
    return UsersSelectionState(
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
