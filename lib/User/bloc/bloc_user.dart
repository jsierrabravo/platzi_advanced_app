// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_advanced_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  // Flujo de datos - stream
  // stream - firebase
  // StreamControler
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  // casos uso
  // 1. Sign in a la aplicación Google
  Future<User> signIn() {
    return _auth_repository.signInFirebase();
  }

  @override
  void dispose() {}
}
