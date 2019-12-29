import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String name;
  String email;
  String userId;

  UserModel({this.userId, this.name, this.email});

  UserModel.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.value != null) {
      userId = snapshot == null ? null : snapshot.value["userId"];
      name = snapshot.value["name"];
      email = snapshot.value["email"];
    }
  }

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        email = json['email'],
        userId = json['userId'];

  toJson() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
    };
  }
}
