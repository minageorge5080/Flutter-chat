import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat/base/BaseScreenState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/models/UserModel.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAndRegisterPresenter {
  BaseScreenState screen;

  FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookSignIn = new FacebookLogin();

  LoginAndRegisterPresenter({this.screen});

  Future<bool> processLogin(String email, String password) async {
    screen.showProgress();

    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      screen.hideProgress();
      return result.user.uid.length > 0;
    } catch (e) {
      screen.hideProgress();
      screen.showErrorMsg(e.message);
      return false;
    }
  }

  Future<bool> processFacebookLogin() async {
    try {
      FacebookLoginResult fbResult = await _facebookSignIn.logIn(['email']);
      if (fbResult.status == FacebookLoginStatus.loggedIn) {
        screen.showProgress();
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: fbResult.accessToken.token);
        AuthResult result =
            await _firebaseAuth.signInWithCredential(credential);
        await _database
            .reference()
            .child("Users")
            .child(result.user.uid)
            .once()
            .then((DataSnapshot snapshot) async {
          UserModel user = UserModel.fromSnapshot(snapshot);

          if (user.email == null) {
            final graphResponse = await http.get(
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${fbResult.accessToken.token}');

            final profile = json.decode(graphResponse.body);
            user = UserModel(userId: result.user.uid, name: profile['name'], email: profile['email']);

            await _database
                .reference()
                .child("Users")
                .child(result.user.uid)
                .update(user.toJson());
          }
        });

        screen.hideProgress();
        return result.user.uid.length > 0;
      }
      return false;
    } catch (e) {
      screen.hideProgress();
      print("Error ${e}");
      screen.showErrorMsg(e.message);
      return false;
    }
  }

  Future<bool> processRegister(String name, String email, String password) async {
    screen.showProgress();
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      if (user.uid.length > 0 && user.uid != null) {
        var userModel = UserModel(userId: user.uid, name: name, email: email);
        await _database
            .reference()
            .child("Users")
            .child(user.uid)
            .update(userModel.toJson());

        screen.hideProgress();
        return true;
      } else {
        screen.hideProgress();
        return false;
      }
    } catch (e) {
      screen.hideProgress();
      screen.showErrorMsg(e.message);
      return false;
    }
  }
}
