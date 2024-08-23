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

  Map<String, dynamic> toJson() => {
        'cards': stack.map((card) => card.toJson()).toList(),
      };

  static ColumnHiddenCard fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    List<PlayingCard> cards =
        cardsJson.map((cardJson) => PlayingCard.fromJson(cardJson)).toList();
    return ColumnHiddenCard(cards);
  }
}
