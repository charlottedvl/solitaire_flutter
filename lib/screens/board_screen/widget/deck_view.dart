import 'package:flutter/material.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class DeckView extends StatelessWidget {
  List<PlayingCard> deck;

  DeckView(this.deck, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: implement display cards
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove padding
      ),
      child: CardView(),
    );
  }
}
