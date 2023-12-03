import 'package:flutter/material.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';

class DraggableCard extends StatefulWidget {
  PlayingCard card;
  String media = "backgroundCard";
  List<PlayingCard> cards;
  ColumnCard column;
  int indexOfCards;
  List<PlayingCard> data;
  List<double> opacities;
  Function(int index) updateDraggableColumn;
  Function(bool visible, int index) changeOpacity;

  DraggableCard({
    super.key,
    required this.card,
    required this.cards,
    required this.column,
    required this.indexOfCards,
    required this.data,
    required this.opacities,
    required this.updateDraggableColumn,
    required this.changeOpacity,
  });

  @override
  State<DraggableCard> createState() => DraggableCardState();
}

class DraggableCardState extends State<DraggableCard> {
  double spacing = 25.0;
  double totalHeight = 500;

  @override
  Widget build(BuildContext context) {
    return Draggable<List<PlayingCard>>(
      data: widget.data,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      onDragStarted: () {
        // Hide the cards in the column
        widget.changeOpacity(false, widget.indexOfCards);
      },
      onDragCompleted: () {
        // Update the column of draggable cards
        widget.updateDraggableColumn(widget.indexOfCards);
      },
      onDragEnd: (details) {
        // Show the cards in the column
        widget.changeOpacity(true, widget.indexOfCards);
      },
      feedback: SizedBox(
        height: totalHeight,
        width: 61.0,
        child: Stack(children: <Widget>[
          for (int i = 0; i < widget.cards.length; i++) ...[
            Positioned(
                top: (i - widget.indexOfCards) * spacing,
                child: Opacity(
                    opacity: widget.opacities[i],
                    child: CardView(
                        card: widget.cards[i]
                    )
                )
            ),
          ]
        ]),
      ),
      childWhenDragging: Opacity(
          opacity: widget.opacities[widget.indexOfCards], child: CardView()),
      child: CardView(
        card: widget.card,
        opacity: widget.opacities[widget.indexOfCards],
      ),
    );
  }
}
