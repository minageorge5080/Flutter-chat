import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat/base/BaseScreenState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/models/UserModel.dart';

class HostPresenter {
  BaseScreenState screen;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HostPresenter({this.screen});

  Future<List<UserModel>> getUsersList() async {

    List<UserModel> users = [];
    await _database
        .reference()
        .child("Users")
        .once()
        .then((DataSnapshot snapshot) async {
          print(snapshot.value.toString());
          snapshot.value.forEach((v){
            users.add(UserModel.fromJson(json.decode(json.encode(v))));
          });

    });
    return users;
  }
}
