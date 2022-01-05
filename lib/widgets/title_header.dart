// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  // ignore: prefer_const_constructors_in_immutables
  TitleHeader({Key key, @required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
          )
        );
  }
}
