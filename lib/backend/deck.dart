import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class Deck extends StackCard<PlayingCard> {
  int cardToShow;

  @override
  bool isCardAddable(card) {
    return false;
  }


  Map<String, dynamic> toJson() => {
    'cards': stack.map((card) => card.toJson()).toList(),
    'cardToShow': cardToShow,
  };


  static Deck fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    List<PlayingCard> cards = cardsJson.map((cardJson) => PlayingCard.fromJson(cardJson)).toList();
    return Deck(cards, json['cardToShow']);
  }

  Deck(List<PlayingCard> stack, this.cardToShow) {
    this.stack = stack;
  }

  void flipDeck(Deck display) {
    while (display.getStack().isNotEmpty) {
      PlayingCard? card = display.pop();
      if (card != null) {
        push(card);
      }
    }
  }

  void addToDisplay(Deck display) {
    if (length < cardToShow) {
      cardToShow = length;
    }
    display.cardToShow = cardToShow;
    for (int index = 0; index < cardToShow; index++) {
      PlayingCard? card = pop();
      if (card != null) {
        display.push(card);
      }
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
