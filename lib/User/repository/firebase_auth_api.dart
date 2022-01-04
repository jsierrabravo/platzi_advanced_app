// ignore_for_file: file_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      // cancelled login
      //print('Google Signin ERROR! googleUser: null!');
      return null;
    }
    final GoogleSignInAuthentication gSA =
        await googleSignInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    return user;
  }

  signOut() async {
    await _auth.signOut();//.then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut();
    //print("Sesiones cerradas");
  }
}
