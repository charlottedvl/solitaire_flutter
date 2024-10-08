import 'package:solitaire/backend/models/playing_card.dart';
import 'package:solitaire/backend/models/color_card.dart';
import 'package:solitaire/backend/models/stack_card.dart';

class ColoredStack extends StackCard {
  ColorCard? color;

  ColoredStack(List<PlayingCard> stack, this.color) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(cards) {
    if (cards.length == 1) {
      if ((stack.isEmpty && cards[0].value == 1)) {
        color = cards[0].color;
        return true;
      } else if (color?.getColorCardName() ==
              cards[0].getColor().getColorCardName() &&
          (stack.isNotEmpty && cards[0].value == (stack.last.value + 1))) {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'stack': stack.map((card) => card.toJson()).toList(),
        'color': color?.toJson(),
      };

  static ColoredStack fromJson(Map<String, dynamic> json) {
    var stackJson = json['stack'] as List;
    List<PlayingCard> stack =
        stackJson.map((cardJson) => PlayingCard.fromJson(cardJson)).toList();
    ColorCard? color;
    if (json['color'] != null) {
      color = ColorCard.fromJson(json['color']);
    }
    return ColoredStack(stack, color);
  }

  void testIfEmpty() {
    if (stack.isNotEmpty) {
      stack.last.setIsVisible(true);
    } else {
      color = null;
    }
  }
}
