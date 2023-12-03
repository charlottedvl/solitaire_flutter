import 'package:flutter/material.dart';
import 'package:solitaire/backend/deck.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';

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
    double height = 79.0;

    int length = displayDeck.length;
    int cardToShow = displayDeck.cardToShow;
    return SizedBox(
      height: height,
      width: 100.0,
      child: Stack(
        children: <Widget>[
          if (displayDeck.getStack().isNotEmpty) ...[
            for (int j = 0; j < cardToShow; j++) ...[
              Positioned(
                  left: j * spacing,
                  child: j != cardToShow - 1
                      ? CardView(card: displayDeck.getStack()[length - (j + 1)])
                      : Draggable<List<PlayingCard>>(
                          data: [displayDeck.getStack()[length - (j + 1)]],
                          dragAnchorStrategy: pointerDragAnchorStrategy,
                          onDragCompleted: () {
                            displayDeck.getStack().removeAt(length - (j + 1));
                            setState(() {
                              if (cardToShow != 1) {
                                cardToShow--;
                              }
                            });
                          },
                          feedback: CardView(
                              card: displayDeck.getStack()[length - (j + 1)]),
                          childWhenDragging: cardToShow != 1 || length < 2
                              ? Opacity(opacity: 0.0, child: CardView())
                              : CardView(
                                  card: displayDeck.getStack()[length - 2],
                                ),
                          child: CardView(
                              card: displayDeck.getStack()[length - (j + 1)]),
                        )),
            ],
          ],
        ],
      ),
    );
  }
}
