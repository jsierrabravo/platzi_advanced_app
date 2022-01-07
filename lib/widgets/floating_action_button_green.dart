// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const FloatingActionButtonGreen({
    Key key,
    @required this.iconData,
    this.onPressed //@required this.onPressed
  });

  @override
  State<StatefulWidget> createState() {
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  // void onPressedFav() {
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text("Agregaste a tus Favoritos"),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
      heroTag: null,
    );
  }
}
