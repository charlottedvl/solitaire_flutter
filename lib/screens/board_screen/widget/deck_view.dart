import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class DeckView extends StatelessWidget {
  List<Card> deck = [];

  DeckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: [
        for (Card card in deck) ...[
          CardView("backgroundCard"),
        ]
      ],
    );
  }

}