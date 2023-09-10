import 'package:flutter/material.dart';

enum ColorCardName { Club, Diamonds, Spade, Heart }

class ColorCard {
  ColorCardName name;
  Color color;

  ColorCard(this.color, this.name);

  String getColorCardName() {
    return name.toString().split('.').last;
  }

  Color getColor() {
    return color;
  }
}
