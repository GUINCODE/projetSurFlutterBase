import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UserEvent {
  const GetUsersEvent();
}

class GetUserByIdEvent extends UserEvent {
  final int id;
  const GetUserByIdEvent({required this.id});
}
