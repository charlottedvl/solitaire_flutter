import 'package:flutter/material.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class ColumnCardView extends StatelessWidget {
  ColumnCard column;
  const ColumnCardView(this.column, {super.key,
  });

  @override
  Widget build(BuildContext context) {
    int numberColumn = 5;
    double spacing = 25.0;
    double totalHeight = 500;

    return SizedBox(
      height: totalHeight,
      width:61.0,
      child: Stack(
        children: <Widget>[
          for (int j = 0; j < numberColumn; j++) ...[
            Positioned(
              top: j * spacing,
              child: j != numberColumn - 1
                  ? CardView("backgroundCard")
                  : LongPressDraggable<CardView>(
                delay: const Duration(milliseconds: 10),
                dragAnchorStrategy: pointerDragAnchorStrategy,
                feedback: CardView("backgroundCard"),
                child: CardView("backgroundCard"),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
