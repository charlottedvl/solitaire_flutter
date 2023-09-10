import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class ColoredStack extends StackCard {
  ColorCard? color;

  ColoredStack(List<PlayingCard> stack) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(card) {
    if (color == card.getColor()) {
      if ((stack.isEmpty && card.value == 1) ||
          (stack.isNotEmpty && card.value == (stack.last.value + 1))) {
        return true;
      }
    }
    return false;
  }
}
