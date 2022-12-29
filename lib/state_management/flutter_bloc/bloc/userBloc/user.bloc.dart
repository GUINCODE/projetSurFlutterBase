import 'dart:convert';

import 'package:app/models/user_model.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user.event.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    // ignore: void_checks
    on<GetUsersEvent>((event, emit) async {
      // mise à jour de l'état en mode "loading" avant de faire appel à l'API
      emit(const UserLoadingState());
      await _getUsers().then((users) {
        // mise à jour de l'état avec la liste d'utilisateurs récupérée
        emit(UserSuccessState(status: UserStatus.success, users: users));
      }).catchError((error) {
        print(error);
        // mise à jour de l'état en cas d'erreur lors de la récupération des utilisateurs
        emit(UserErrorState(status: UserStatus.error, error: error));
      });
    });
    on<GetUserByIdEvent>((event, emit) async {
      emit(const UserLoadingState());
      await _getUserById(event.id).then((users) {
        emit(UserSuccessState(status: UserStatus.success, users: users));
      }).catchError((error) {
        // mise à jour de l'état en cas d'erreur lors de la récupération de l'utilisateur
        emit(UserErrorState(
            status: UserStatus.error,
            error: 'User with id ${event.id} not found'));
      });
    });
  }

  // méthode pour faire appel à l'API et récupérer la liste d'utilisateurs
  Future<List<UserModel>> _getUsers() async {
    var response = await http.get(Uri.parse('http://localhost:3000/users'));
    final List<dynamic> jsonList = jsonDecode(response.body);
    List<UserModel> users = UserModel.fromJsonList(jsonList);

    return users;
  }

  // méthode pour faire appel à l'API et récupérer un utilisateur par son ID
  Future<List<UserModel>> _getUserById(int id) async {
    var response = await http.get(Uri.parse('http://localhost:3000/users/$id'));
    final Map<String, dynamic> json = jsonDecode(response.body);
    UserModel user = UserModel.fromJson(json);

    return [user];
  }
}
