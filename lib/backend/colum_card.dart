import 'package:solitaire/backend/column_draggable_card.dart';
import 'package:solitaire/backend/column_hidden_card.dart';
import 'package:solitaire/backend/playing_card.dart';

class ColumnCard {
  ColumnHiddenCard columnHiddenCard;
  ColumnDraggableCard columnDraggableCard;

  ColumnCard(this.columnDraggableCard, this.columnHiddenCard);

  int getLength() {
    return (columnDraggableCard.length + columnHiddenCard.length);
  }

  void testEmptyColumnDraggableCard() {
    if (columnHiddenCard.getStack().isNotEmpty) {
      if (columnDraggableCard.getStack().isEmpty) {
        PlayingCard cardToSwitch = columnHiddenCard.pop();
        cardToSwitch.setIsVisible(true);
        columnDraggableCard.push(cardToSwitch);
      }
    }
  }
}
