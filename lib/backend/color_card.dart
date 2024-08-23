import 'package:flutter/material.dart';

enum ColorCardName { Club, Diamonds, Spade, Heart }

class ColorCard {
  ColorCardName name;
  Color color;

  ColorCard(this.color, this.name);

  Map<String, dynamic> toJson() {
    var json = {
      'color': (color == Colors.black ? 0 : 1),
      'name': name.toString()
    };
    return json;
  }

  static ColorCard fromJson(Map<String, dynamic> json) {
    ColorCardName color = ColorCardName.Heart;
    switch (json['name']) {
      case 'ColorCardName.Spade':
        color = ColorCardName.Spade;
      case 'ColorCardName.Heart':
        color = ColorCardName.Heart;
      case 'ColorCardName.Club':
        color = ColorCardName.Club;
      case 'ColorCardName.Diamonds':
        color = ColorCardName.Diamonds;
    }
    return ColorCard(json['color'] == 0 ? Colors.black : Colors.red, color);
  }

  String getColorCardName() {
    return name.toString().split('.').last;
  }
}
