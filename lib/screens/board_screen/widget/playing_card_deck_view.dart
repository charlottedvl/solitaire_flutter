
import 'package:flutter/material.dart';

class PlayingCardDeckView extends StatelessWidget {
  const PlayingCardDeckView({super.key});

  @override
  Widget build(BuildContext context) {
    int numberCards = 3;
    double spacing = 25.0;
    double height = 79.0;

    return SizedBox(
      height: height,
      width:100.0,
      child: Stack(
        children: <Widget>[
          for (int j = 0; j < numberCards; j++) ...[
            Positioned(
              left: j * spacing,
              child: j != numberCards - 1
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