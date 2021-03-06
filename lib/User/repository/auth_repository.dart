import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_advanced_app/User/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<User> signInFirebase() => _firebaseAuthAPI.signIn();
  /*
  Future<User> signInFirebase() {
    if (_firebaseAuthAPI!=null) {
      _firebaseAuthAPI.signIn();  
    }
  }
  */
  signOut() => _firebaseAuthAPI.signOut();
}
