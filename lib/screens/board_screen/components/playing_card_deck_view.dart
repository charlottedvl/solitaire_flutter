import 'package:flutter/material.dart';
import 'package:solitaire/backend/deck.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/shared/constants.dart';

class PlayingCardDeckView extends StatefulWidget {
  Deck displayDeck;

  PlayingCardDeckView(this.displayDeck, {super.key});

  @override
  PlayingCardDeckViewState createState() => PlayingCardDeckViewState();
}

class PlayingCardDeckViewState extends State<PlayingCardDeckView> {
  late Deck displayDeck;

  @override
  void initState() {
    super.initState();
    displayDeck = widget.displayDeck;
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 25.0;
    double height = cardHeight;

    int length = displayDeck.length;
    return SizedBox(
      height: height,
      width: 100.0,
      child: Stack(
        children: <Widget>[
          if (displayDeck.getStack().isNotEmpty) ...[
            for (int j = 1; j < displayDeck.cardToShow + 1; j++) ...[
              Positioned(
                  left: (j - 1) * spacing,
                  child: j != displayDeck.cardToShow
                      // If there is more than 1 card to display,
                      // make the other ones not draggable
                      ? CardView(card: displayDeck.getStack()[length - j])
                      : Draggable<List<PlayingCard>>(
                          data: [displayDeck.getStack()[length - j]],
                          dragAnchorStrategy: pointerDragAnchorStrategy,
                          onDragCompleted: () {
                            displayDeck.getStack().removeAt(length - j);
                            setState(() {
                              if (displayDeck.cardToShow != 1) {
                                displayDeck.cardToShow--;
                              }
                            });
                          },
                          feedback: CardView(
                              card: displayDeck.getStack()[length - j]),
                          childWhenDragging: displayDeck.cardToShow != 1 ||
                                  length < 2
                              ? Opacity(
                                  opacity: opacityHiddenCard, child: CardView())
                              // If there is only one card to display and
                              // the deck has more than 2 cards,*
                              // then display a card when the last card is moving
                              : CardView(
                                  card: displayDeck.getStack()[length - 2],
                                ),
                          child: CardView(
                              card: displayDeck.getStack()[length - j]),
                        )),
            ],
          ],
        ],
      ),
    );
  }
}
