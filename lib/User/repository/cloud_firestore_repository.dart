// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_advanced_app/Place/model/place.dart';
import 'package:platzi_advanced_app/User/model/user.dart';
import 'package:platzi_advanced_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_advanced_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreApi = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreApi.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreApi.updatePlaceData(place);

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreApi.buildPlaces(placesListSnapshot);
}
