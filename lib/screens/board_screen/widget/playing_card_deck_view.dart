import 'package:flutter/material.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class PlayingCardDeckView extends StatelessWidget {
  List<PlayingCard> discardDeck;
  List<PlayingCard> displayDeck = <PlayingCard>[];

  PlayingCardDeckView(this.discardDeck, {super.key});

  @override
  Widget build(BuildContext context) {
    int numberCards = 3;
    double spacing = 25.0;
    double height = 79.0;

    int length = discardDeck.length;

    if (length == 3) {
      displayDeck.add(discardDeck[length - 3]);
      displayDeck.add(discardDeck[length - 2]);
      displayDeck.add(discardDeck.last);
    } else if (length == 2) {
      displayDeck.add(discardDeck[length - 2]);
      displayDeck.add(discardDeck.last);
    } else if (length == 1) {
      displayDeck.add(discardDeck.last);
    }

    return SizedBox(
      height: height,
      width: 100.0,
      child: Stack(
        children: <Widget>[
          for (int j = 0; j < length; j++) ...[
            Positioned(
              left: j * spacing,
              child: j != numberCards - 1
                  ? CardView(card: displayDeck[j])
                  : Draggable<CardView>(
                      dragAnchorStrategy: pointerDragAnchorStrategy,
                      feedback: CardView(card: displayDeck[j]),
                      child: CardView(card: displayDeck[j]),
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
