
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class ColumnDraggableCard extends StackCard {

  ColumnDraggableCard(List<PlayingCard> stack) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(card) {
    if ((stack.isNotEmpty &&
        card.color.color != stack.last.color.color &&
        card.value == (stack.last.value - 1)) ||
        stack.isEmpty && card.value == 13) {
      return true;
    }
    return false;
  }

}