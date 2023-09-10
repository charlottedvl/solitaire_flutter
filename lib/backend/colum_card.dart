import 'package:solitaire/backend/column_draggable_card.dart';
import 'package:solitaire/backend/column_hidden_card.dart';

class ColumnCard {
  ColumnHiddenCard columnHiddenCard;
  ColumnDraggableCard columnDraggableCard;

  ColumnCard(this.columnDraggableCard, this.columnHiddenCard);

  int getLength() {
    return (columnDraggableCard.length + columnHiddenCard.length);
  }
}
