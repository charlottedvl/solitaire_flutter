import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/colum_card.dart';
import 'package:solitaire/backend/models/column_draggable_card.dart';
import 'package:solitaire/backend/models/column_hidden_card.dart';
import 'package:solitaire/backend/models/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/screens/board_screen/widgets/draggable_card.dart';
import 'package:solitaire/shared/constants.dart';
import 'package:solitaire/screens/shared/widget/empty_stack.dart';

class ColumnCardView extends StatefulWidget {
  // Card column
  ColumnCard column;
  // Number of move played by the player
  int counter;

  Function saveMove;

  ColumnCardView(
      {super.key,
      required this.column,
      required this.counter,
      required this.saveMove});

  @override
  ColumnCardViewState createState() => ColumnCardViewState();
}

class ColumnCardViewState extends State<ColumnCardView> {
  // Draggable cards
  late ColumnDraggableCard columnDraggable;
  // Hidden cards
  late ColumnHiddenCard columnHidden;
  // Copy of the draggable stack
  late List<PlayingCard> stackCopy;
  // Opacities of the draggable cards
  List<double> opacities = [];

  @override
  void initState() {
    super.initState();
    columnDraggable = widget.column.columnDraggableCard;
    columnHidden = widget.column.columnHiddenCard;
    stackCopy = List.from(widget.column.columnDraggableCard.getStack());
    opacities = List.generate(stackCopy.length, (index) => 1.0);
  }

  /// Update the draggable column
  void updateDraggableColumn(int index) {
    columnDraggable.popAllFromIndex(index);
    widget.column.testEmptyColumnDraggableCard();
    setState(() {
      stackCopy = List.from(widget.column.columnDraggableCard.getStack());
    });
  }

  /// Change the opacity and rebuild the widget
  void changeOpacity(bool visible, int index) {
    setState(() {
      for (int i = index; i < opacities.length; i++) {
        opacities[i] = visible ? 1 : 0;
      }
    });
  }

  /// Add card to column
  void addCardsToColumn(List<PlayingCard> data) {
    columnDraggable.pushAll(data);
    setState(() {
      stackCopy = List.from(columnDraggable.getStack());
      opacities = List.generate(stackCopy.length, (index) => 1.0);
      widget.counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = originalCardWidth / originalCardHeight;

    final double screenWidth = MediaQuery.of(context).size.width;

    final double width = screenWidth * 0.13;
    final double height = width / aspectRatio;
    double spacing = 25.0;
    double totalHeight = MediaQuery.of(context).size.height * 0.64;
    return SizedBox(
        height: totalHeight,
        width: 61.0,
        child: Stack(children: <Widget>[
          Positioned(
            top: 0,
            child: EmptyStack(),
          ),
          for (PlayingCard card in columnHidden.getStack()) ...[
            Positioned(
                top: columnHidden.getStack().indexOf(card) * spacing,
                child: CardView(card: card)),
          ],
          for (PlayingCard card in stackCopy) ...[
            Positioned(
                top: (stackCopy.indexOf(card) + columnHidden.length) * spacing,
                child: DraggableCard(
                  card: card,
                  indexOfCards: stackCopy.indexOf(card),
                  column: widget.column,
                  cards: stackCopy,
                  opacities: opacities,
                  changeOpacity: changeOpacity,
                  data: List.from(stackCopy.sublist(stackCopy.indexOf(card))),
                  updateDraggableColumn: updateDraggableColumn,
                )),
          ],
          Positioned(
            top: (widget.column.getLength() - 1) * spacing,
            child: DragTarget(onWillAccept: (data) {
              if (data is List<PlayingCard>) {
                return columnDraggable.isCardAddable(data);
              }
              return false;
            }, onAccept: (data) {
              widget.saveMove();
              if (data is List<PlayingCard>) {
                addCardsToColumn(data);
              }
            }, builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return SizedBox(
                width: width,
                height: height,
              );
            }),
          ),
        ]));
  }
}
