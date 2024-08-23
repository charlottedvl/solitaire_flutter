import 'package:solitaire/backend/models/playing_card.dart';
import 'package:solitaire/backend/models/stack_card.dart';

class ColumnDraggableCard extends StackCard {
  ColumnDraggableCard(List<PlayingCard> stack) {
    this.stack = stack;
  }

  @override
  bool isCardAddable(cards) {
    if ((stack.isNotEmpty &&
            cards[0].color.color != stack.last.color.color &&
            cards[0].value == (stack.last.value - 1)) ||
        stack.isEmpty && cards[0].value == 13) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'cards': stack.map((card) => card.toJson()).toList(),
      };

  static ColumnDraggableCard fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    List<PlayingCard> cards =
        cardsJson.map((cardJson) => PlayingCard.fromJson(cardJson)).toList();
    return ColumnDraggableCard(cards);
  }

  void popAllFromIndex(int index) {
    List<PlayingCard> cardsToMove = List.from(stack.sublist(index));
    for (PlayingCard card in cardsToMove) {
      pop();
    }
  }

  void pushAll(List<PlayingCard> cardsToMove) {
    for (PlayingCard card in cardsToMove) {
      push(card);
    }
  }
}
