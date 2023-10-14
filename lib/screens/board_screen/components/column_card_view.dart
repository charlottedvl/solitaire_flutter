import 'package:flutter/material.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';

class ColumnCardView extends StatefulWidget {
  ColumnCard column;

  ColumnCardView(this.column, {Key? key}) : super(key: key);

  @override
  ColumnCardViewState createState() => ColumnCardViewState();
}

class ColumnCardViewState extends State<ColumnCardView> {
  late ColumnCard column;
  late List<PlayingCard> stackCopy;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    column = widget.column;
    stackCopy = List.from(column.columnDraggableCard.getStack());
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 25.0;
    double totalHeight = 500;
    // TODO: Make sure the column isn't displaying anything when the column is empty
    return SizedBox(
        height: totalHeight,
        width: 61.0,
        child: Stack(children: <Widget>[
          for (PlayingCard card in column.columnHiddenCard.getStack()) ...[
            Positioned(
                top: column.columnHiddenCard.getStack().indexOf(card) * spacing,
                child: CardView(card: card)),
          ],
          if (stackCopy.isNotEmpty) ...[
            for (PlayingCard card in stackCopy) ...[
              Positioned(
                  top: (stackCopy.indexOf(card) +
                          column.columnHiddenCard.length) *
                      spacing,
                  child: Draggable<List<PlayingCard>>(
                    data: List.from(stackCopy.sublist(stackCopy.indexOf(card))),
                    dragAnchorStrategy: pointerDragAnchorStrategy,
                    onDragStarted: () {
                      setState(() {
                        this.opacity = 0.0;
                      });
                    },
                    onDragCompleted: () {
                      column.columnDraggableCard
                          .popAllFromIndex(stackCopy.indexOf(card));
                      column.testEmptyColumnDraggableCard();
                      setState(() {
                        stackCopy =
                            List.from(column.columnDraggableCard.getStack());
                      });
                    },
                    onDragEnd: (details) {
                      setState(() {
                        opacity = 1.0;
                      });
                    },
                    feedback: SizedBox(
                      height: totalHeight,
                      width: 61.0,
                      child: Stack(children: <Widget>[
                        for (int i = stackCopy.indexOf(card);
                            i < stackCopy.length;
                            i++) ...[
                          Positioned(
                              top: (i - stackCopy.indexOf(card)) * spacing,
                              child: CardView(card: stackCopy[i])),
                        ]
                      ]),
                    ),
                    childWhenDragging: Opacity(opacity: 0.0, child: CardView()),
                    child: CardView(
                      card: card,
                      opacity: this.opacity,
                    ),
                  )),
            ],
          ] else ...[
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 79,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(),
              ),
            ),
          ],
          Positioned(
            top: (column.getLength() - 1) * spacing,
            child: DragTarget(onWillAccept: (data) {
              if (data is List<PlayingCard>) {
                return column.columnDraggableCard.isCardAddable(data);
              }
              return false;
            }, onAccept: (data) {
              if (data is List<PlayingCard>) {
                column.columnDraggableCard.pushAll(data);
                setState(() {
                  stackCopy = List.from(column.columnDraggableCard.getStack());
                });
              }
            }, builder: (
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
