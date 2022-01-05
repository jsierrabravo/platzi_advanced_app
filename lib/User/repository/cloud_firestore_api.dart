// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:platzi_advanced_app/Place/model/place.dart';
import 'package:platzi_advanced_app/User/model/user.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseUser.FirebaseAuth _auth = FirebaseUser.FirebaseAuth.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);

      String uid = (await _auth.currentUser).uid; 
      await refPlaces.add({
        'name': place.name,
        'description': place.description,
        'likes': place.likes,
        'userOwner': "$USERS/$uid" // reference
      });


    // await _auth.currentUser.then((FirebaseUser.User user) {
    //   refPlaces.add({
    //     'name': place.name,
    //     'description': place.description,
    //     'likes': place.likes,
    //     'userOwner': "${USERS}/${user.uid}" // reference
    //   });
    // });
  }
}
