import 'package:app/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  const UserInitialState();
}

enum UserStatus { loading, success, error }

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserSuccessState extends UserState {
  final UserStatus status;
  final List<UserModel> users;
  const UserSuccessState({required this.status, required this.users});
}

class UserErrorState extends UserState {
  final UserStatus status;
  final String error;
  const UserErrorState({required this.status, required this.error});
}
