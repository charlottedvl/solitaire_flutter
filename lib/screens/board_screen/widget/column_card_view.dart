import 'package:flutter/material.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class ColumnCardView extends StatefulWidget {
  ColumnCard column;

  ColumnCardView(this.column, {Key? key}) : super(key: key);

  @override
  ColumnCardViewState createState() => ColumnCardViewState();
}

class ColumnCardViewState extends State<ColumnCardView> {
  late ColumnCard column;

  @override
  void initState() {
    super.initState();
    column = widget.column;
  }




  @override
  Widget build(BuildContext context) {
    double spacing = 25.0;
    double totalHeight = 500;

    return SizedBox(
        height: totalHeight,
        width: 61.0,
        child: Stack(children: <Widget>[
          for (PlayingCard card in column.columnHiddenCard.getStack()) ...[
            Positioned(
                top: column.columnHiddenCard.getStack().indexOf(card) * spacing,
                child: CardView(card: card)
            ),
          ],
          for (PlayingCard card in column.columnDraggableCard.getStack()) ...[
            Positioned(
                top: (column.columnDraggableCard.getStack().indexOf(card) + column.columnHiddenCard.length) * spacing,
                child: Draggable<PlayingCard>(
                  data: card,
                  dragAnchorStrategy: pointerDragAnchorStrategy,
                  onDragCompleted: () {
                    column.columnDraggableCard.pop();
                    column.columnHiddenCard.getStack().last.setIsVisible(true);
                    setState(() { });
                  },
                  feedback: CardView(card: card),
                  childWhenDragging:
                  Opacity(opacity: 0.0, child: CardView()),
                  child: CardView(card: card),
                )
            ),

          ],
          Positioned(
            top: (column.getLength() - 1) * spacing,
            child: DragTarget(
                onWillAccept: (card) => column.columnDraggableCard.isCardAddable(card),
                onAccept: (card) => {
                  column.columnDraggableCard.push(card),
                  setState(() {

                  }),
                },
                builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                    ) {
                  return const SizedBox(
                    width: 50,
                    height: 79,
                  );
                }),
          ),
        ]));
  }

}
