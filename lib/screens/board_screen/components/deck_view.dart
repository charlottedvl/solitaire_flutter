import 'package:flutter/material.dart';
import 'package:solitaire/backend/deck.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/shared/widget/empty_stack.dart';

class DeckView extends StatelessWidget {
  Deck nextCardsDeck;
  Deck displayDeck;
  final VoidCallback onPressedCallback;

  DeckView(this.nextCardsDeck, this.displayDeck,
      {required this.onPressedCallback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (nextCardsDeck.getStack().isNotEmpty) {
          nextCardsDeck.addToDisplay(displayDeck);
        } else {
          nextCardsDeck.flipDeck(displayDeck);
        }
        onPressedCallback();
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
