import 'package:flutter/material.dart';
import 'package:solitaire/backend/deck.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class DeckView extends StatelessWidget {
  Deck nextCardsDeck;
  Deck displayDeck;
  final VoidCallback onPressedCallback;

  DeckView(this.nextCardsDeck, this.displayDeck,
      {required this.onPressedCallback, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (nextCardsDeck
            .getStack()
            .isNotEmpty) {
          nextCardsDeck.addToDisplay(displayDeck);
        } else {
          nextCardsDeck.flipDeck(displayDeck);
        }
        onPressedCallback();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: nextCardsDeck
          .getStack()
          .isNotEmpty
          ? CardView()
          : Opacity(
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
              child: const Icon(
                Icons.refresh,  // Change to the desired icon
                color: Colors.white,
                size: 32.0,  // Adjust the size as needed
          ),
        ),
      ),
    );
  }
}