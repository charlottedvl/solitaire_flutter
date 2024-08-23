import 'package:solitaire/backend/models/column_draggable_card.dart';
import 'package:solitaire/backend/models/column_hidden_card.dart';
import 'package:solitaire/backend/models/playing_card.dart';

class ColumnCard {
  ColumnHiddenCard columnHiddenCard;
  ColumnDraggableCard columnDraggableCard;

  ColumnCard(this.columnDraggableCard, this.columnHiddenCard);

  Map<String, dynamic> toJson() => {
        'draggableCard': columnDraggableCard.toJson(),
        'hiddenCard': columnHiddenCard.toJson(),
      };

  static ColumnCard fromJson(Map<String, dynamic> json) {
    return ColumnCard(
      ColumnDraggableCard.fromJson(json['draggableCard']),
      ColumnHiddenCard.fromJson(json['hiddenCard']),
    );
  }

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
