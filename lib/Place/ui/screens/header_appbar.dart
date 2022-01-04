// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:platzi_advanced_app/widgets/gradient_back.dart';
import 'package:platzi_advanced_app/Place/ui/widgets/card_image_list.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack(height: 250.0),
        CardImageList()
      ],
    );
  }

}