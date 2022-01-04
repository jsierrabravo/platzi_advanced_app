// ignore_for_file: use_key_in_widget_constructors, library_prefixes

import 'package:flutter/material.dart';
import 'package:platzi_advanced_app/widgets/gradient_back.dart';
import 'package:platzi_advanced_app/widgets/buton_green.dart';
import 'package:platzi_advanced_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:platzi_advanced_app/platzi_trips_cupertino.dart';
import 'package:platzi_advanced_app/User/model/user.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  UserBloc userBloc;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    screenWidth = MediaQuery.of(context).size.width;
    return _handleCurrentSesion();
  }

  Widget _handleCurrentSesion() {
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return signInGoogleUI();
          } else {
            return PlatziTripsCupertino();
          }
        });
  }

  Widget signInGoogleUI() {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        GradientBack(
          height: null,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0
              ),
              width: screenWidth,
              child: const Text("Welcome, \nThis is your Travel App",
                  style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato", //
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )
          ),
          ButtonGreen(
              text: "Login with Gmail",
              onPressed: () {
                userBloc.signOut();
                userBloc.signIn().then((FirebaseUser.User user) {
                  userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoURL));
                }); //.then((User user) => print("El usuario es ${user.displayName}"));
              },
              width: 300.0,
              height: 50.0)
        ])
      ],
    ));
  }
}
