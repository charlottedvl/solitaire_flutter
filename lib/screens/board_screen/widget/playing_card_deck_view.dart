import 'package:flutter/material.dart';
import 'package:solitaire/backend/deck.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

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

  void updateParentState() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 25.0;
    double height = 79.0;

    int length = displayDeck.length;


    return SizedBox(
      height: height,
      width: 100.0,
      child: Stack(
        children: <Widget>[
          if (displayDeck.getStack().isNotEmpty) ...[
            for (int j = 0; j < displayDeck.cardToShow; j++) ...[
              Positioned(
                  left: j * spacing,
                  // TODO: Fix the position of element in stack
                  child: j != displayDeck.cardToShow - 1
                      ? CardView(card: displayDeck.getStack()[length - (j + 1)])
                      : Draggable<List<PlayingCard>>(
                    data: [displayDeck.getStack()[length - (j + 1)]],
                    dragAnchorStrategy: pointerDragAnchorStrategy,
                    onDragCompleted: () {
                      displayDeck.getStack().removeAt(length - (j + 1));
                      setState(() { if (displayDeck.cardToShow != 1) {
                        displayDeck.cardToShow--;
                      } });
                    },
                    feedback: CardView(card: displayDeck.getStack()[length - (j + 1)]),
                    childWhenDragging:
                    Opacity(opacity: 0.0, child: CardView()),
                    child: CardView(card: displayDeck.getStack()[length - (j + 1)]),
                  )
              ),
            ],
          ],
        ],
      ),
    );
  }
}
