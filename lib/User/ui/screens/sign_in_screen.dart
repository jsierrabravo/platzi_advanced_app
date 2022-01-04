// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:platzi_advanced_app/widgets/gradient_back.dart';
import 'package:platzi_advanced_app/widgets/buton_green.dart';
import 'package:platzi_advanced_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_advanced_app/platzi_trips_cupertino.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
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
        GradientBack("", null),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ignore: prefer_const_constructors
          Text("Welcome \n This is your Travel App",
              style: const TextStyle(
                  fontSize: 37.0,
                  fontFamily: "Lato",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          ButtonGreen(
              text: "Login with Gmail",
              onPressed: () {
                userBloc.signOut();
                userBloc.signIn(); //.then((User user) => print("El usuario es ${user.displayName}"));
              },
              width: 300.0,
              height: 50.0)
        ])
      ],
    ));
  }
}
