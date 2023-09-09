
import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class ColoredStackView extends StatelessWidget {
  const ColoredStackView({super.key});

  @override
  Widget build(BuildContext context) {
    int numberCards = 1;
    int numberStacks = 4;
    double height = 79.0;
    double width = 50.0;

    return Row(
        children: [
          for (int j = 0; j < numberStacks; j++) ...[
            SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: <Widget>[
                  for (int j = 0; j < numberCards; j++) ...[
                    j != numberCards - 1
                        ? CardView("backgroundCard")
                        : LongPressDraggable<CardView>(
                      delay: const Duration(milliseconds: 10),
                      dragAnchorStrategy: pointerDragAnchorStrategy,
                      feedback: CardView("backgroundCard"),
                      child: CardView("backgroundCard"),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ]
    );
  }

}