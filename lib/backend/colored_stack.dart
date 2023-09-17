import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class ColoredStack extends StackCard {
  ColorCard? color;

  ColoredStack(List<PlayingCard> stack) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(cards) {
    if (cards.length == 1) {
      if ((stack.isEmpty && cards[0].value == 1)) {
        color = cards[0].color;
        return true;
      } else
      if (color?.getColorCardName() == cards[0].getColor().getColorCardName() &&
          (stack.isNotEmpty && cards[0].value == (stack.last.value + 1))) {
        return true;
      }
    }
    return false;
  }

  void testIfEmpty() {
    if (stack.isNotEmpty) {
      stack.last.setIsVisible(true);
    } else {
      color = null;
    }
  }
}
