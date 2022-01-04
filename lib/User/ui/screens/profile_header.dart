// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:platzi_advanced_app/User/ui/widgets/user_info.dart';
import 'package:platzi_advanced_app/User/ui/widgets/button_bar.dart';
import 'package:platzi_advanced_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_advanced_app/User/model/user.dart';

class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;
  User user;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      // flujo de datos al que estará apuntando/pendiente
      stream: userBloc.streamFirebase,
      // lo que se va a ejecutar cuando aquello a lo que está alerta, cambie de estado
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.none:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return null;
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logeado");
      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: const <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login")
          ],
        ),
      );
    } else {
      print("Logeado");
      print(snapshot.data);
      user = User(
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      const title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );

      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: const <Widget>[title],
            ),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
