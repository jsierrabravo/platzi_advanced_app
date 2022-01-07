// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_advanced_app/Place/model/place.dart';
import 'package:platzi_advanced_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_advanced_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:platzi_advanced_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_advanced_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_advanced_app/User/model/user.dart';
import 'package:platzi_advanced_app/User/ui/widgets/profile_place.dart';
//import 'package:platzi_advanced_app/User/repository/cloud_firestore_api.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  // Flujo de datos - stream
  // stream - firebase
  // StreamControler
  Stream<FirebaseUser.User> streamFirebase =
      FirebaseUser.FirebaseAuth.instance.authStateChanges();
  Stream<FirebaseUser.User> get authStatus => streamFirebase;
  Future<FirebaseUser.User> get currentUser async =>
      FirebaseUser.FirebaseAuth.instance.currentUser;

  // casos uso
  // 1. Sign in a la aplicación Google
  Future<FirebaseUser.User> signIn() => _auth_repository.signInFirebase();

  // 2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
