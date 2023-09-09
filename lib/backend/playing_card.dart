import 'package:solitaire/backend/color_card.dart';


class PlayingCard {

  ColorCard color;

  int value;

  String media;

  //Color edgeColor; // Black if the card is displayed, Withe if it is a background card

  PlayingCard(this.value, this.color, this.media);

  String getMedia() {
    return media;
  }

  ColorCard getColor() {
    return color;
  }

  int getValue() {
    return value;
  }
}