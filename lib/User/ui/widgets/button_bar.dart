// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_advanced_app/Place/ui/screens/add_place_screen.dart';
import 'circle_button.dart';
import 'package:platzi_advanced_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

// ignore: must_be_immutable
class ButtonsBar extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    final picker = ImagePicker();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            // cambiar la contraseña
            CircleButton(true, Icons.vpn_key, 20.0,
                const Color.fromRGBO(255, 255, 255, 0.6), () => {}),
            // añadir un nuevo lugar
            CircleButton(false, Icons.add, 40.0, 
                const Color.fromRGBO(255, 255, 255, 1), () async {
                  final _navigator = Navigator.of(context);
                  await picker.pickImage(source: ImageSource.camera).then((XFile image) {
                    _navigator.push(
                       MaterialPageRoute(builder: (BuildContext context) => AddPlaceScreen(image: File(image.path)))
                    );
                  });//.catchError((onError) => print(onError));
                  
                }
            ),
            // cerrar sesión
            CircleButton(
                true,
                Icons.exit_to_app,
                20.0,
                const Color.fromRGBO(255, 255, 255, 0.6),
                () => {userBloc.signOut()}),
          ],
        ));
  }
}
