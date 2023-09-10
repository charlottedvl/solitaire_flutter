import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class PlayingCard {
  ColorCard color;

  int value;

  String media;

  bool isVisible = false;

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

  bool getIsVisible() {
    return isVisible;
  }

  void setIsVisible(bool isVisible) {
    this.isVisible = isVisible;
  }

  void addCardToStack(StackCard stack) {
    if (stack.isCardAddable(this)) {
      stack.push(this);
    }
  }
}
