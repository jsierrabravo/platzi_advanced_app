// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:platzi_advanced_app/Place/model/place.dart';
import 'package:platzi_advanced_app/User/model/user.dart';
import 'package:platzi_advanced_app/User/ui/widgets/profile_place.dart';

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

    String uid = (_auth.currentUser).uid;
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'urlImage': place.urlImage,
      'userOwner': _db.doc("$USERS/$uid"), // reference
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        
        DocumentReference refUsers = _db.collection(USERS).doc(uid);
        refUsers.update({
          'myPlaces': FieldValue.arrayUnion([_db.doc("$PLACES/$snapshot.id")])
        });
      });
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
  /*
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    // ignore: avoid_function_literals_in_foreach_calls
    placesListSnapshot.forEach((DocumentSnapshot place) { 
      Map<String, dynamic> data = place.data() as Map<String, dynamic>;
      profilePlaces.add(ProfilePlace(
        Place(
          name: data['name'],
          description: data['description'],
          urlImage: data['urlImage']
        )
      ));
    });

    return profilePlaces;
  }
  */

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    // ignore: avoid_function_literals_in_foreach_calls
    placesListSnapshot.forEach((DocumentSnapshot place) { 
      Map<String, dynamic> data = place.data() as Map<String, dynamic>;
      profilePlaces.add(ProfilePlace(
        Place(
          name: data['name'],
          description: data['description'],
          urlImage: data['urlImage']
        )
      ));
    });

    return profilePlaces;


}
