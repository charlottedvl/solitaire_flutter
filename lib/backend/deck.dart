

import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class Deck extends StackCard {
  int cardToShow;

  @override
  bool isCardAddable(card) {
    return false;
  }

  Deck(List<PlayingCard> stack, this.cardToShow) {
    this.stack = stack;
  }

  void flipDeck(Deck display) {
    while (display.getStack().isNotEmpty) {
      push(display.pop());
    }
  }

  void addToDisplay(Deck display) {
    if (length < cardToShow) {
      cardToShow = length;
    }
    display.cardToShow = cardToShow;
    for (int index = 0; index < cardToShow; index++) {
      display.push(pop());
      display.getStack().last.setIsVisible(true);
    }
    // TODO: pass the settings correctly
    // By default, show 3 cards
    cardToShow = 3;
  }

  void testIfEmpty(Deck display) {
    if (stack.isEmpty) {
      flipDeck(display);
    }
  }

}