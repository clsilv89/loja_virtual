import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  bool isLoading = false;

  FirebaseAuth _oauth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Map<String, dynamic> userData = Map();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFailure}) {
    isLoading = true;
    notifyListeners();

    _oauth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      currentUser = user;

      await _saveUser(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    _oauth.signInWithEmailAndPassword(email: email, password: password);
    if (_oauth.currentUser() != null) {
      print("logou");
    }
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUser(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .setData(userData);
  }

  void recoverPassword() {}
//
//  bool isLoggedIn() {
//
//  }

}
