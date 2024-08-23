import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class PlayingCard {
  ColorCard color;

  int value;

  String media;

  bool isVisible = false;

  PlayingCard(this.value, this.color, this.media, bool? isVisible) {
    this.isVisible = isVisible ?? false;
  }

  Map<String, dynamic> toJson() => {'colorCard': color.toJson(), 'value': value, 'media': media, 'isVisible': isVisible};

  static PlayingCard fromJson(Map<String, dynamic> json) {
    return PlayingCard(json['value'], ColorCard.fromJson(json['colorCard']), json['media'], json['isVisible']);
  }

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
    if (stack.isCardAddable([this])) {
      stack.push(this);
    }
  }
}
