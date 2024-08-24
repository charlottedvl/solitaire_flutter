import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/deck.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/screens/shared/widget/empty_stack.dart';

class DeckView extends StatelessWidget {
  Deck nextCardsDeck;
  Deck displayDeck;
  // Number of move played by the player
  int counter;
  Function saveMove;

  DeckView(
      {super.key,
      required this.nextCardsDeck,
      required this.displayDeck,
      required this.counter,
      required this.saveMove});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        saveMove();
        if (nextCardsDeck.getStack().isNotEmpty) {
          nextCardsDeck.addToDisplay(displayDeck);
        } else {
          nextCardsDeck.flipDeck(displayDeck);
        }
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: nextCardsDeck.getStack().isNotEmpty
          ? CardView()
          : EmptyStack(
              icon: "refresh",
            ),
    );
  }
}
