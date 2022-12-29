// user model
import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String surname;
  final int age;

  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.age});

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      age: json['age'],
    );
  }

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => UserModel.fromJson(e)).toList();
  }
}
