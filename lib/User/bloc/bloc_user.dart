// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'dart:async';

import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_advanced_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:platzi_advanced_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_advanced_app/User/model/user.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  // Flujo de datos - stream
  // stream - firebase
  // StreamControler
  Stream<FirebaseUser.User> streamFirebase = FirebaseUser.FirebaseAuth.instance.authStateChanges();
  Stream<FirebaseUser.User> get authStatus => streamFirebase;

  // casos uso
  // 1. Sign in a la aplicación Google
  Future<FirebaseUser.User> signIn() {
    return _auth_repository.signInFirebase();
  }

  // 2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
