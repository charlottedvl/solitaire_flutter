import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class ColumnHiddenCard extends StackCard {
  ColumnHiddenCard(List<PlayingCard> stack) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(card) {
    return false;
  }
}
