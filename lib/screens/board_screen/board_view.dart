import 'package:flutter/material.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/screens/board_screen/components/column_card_view.dart';
import 'package:solitaire/screens/board_screen/components/playing_card_deck_view.dart';
import 'package:solitaire/screens/board_screen/components/colored_stack_view.dart';
import 'package:solitaire/screens/board_screen/components/deck_view.dart';
import 'package:solitaire/screens/victory_screen/victory.dart';
import 'package:solitaire/shared/constants.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  BoardViewState createState() => BoardViewState();
}

class BoardViewState extends State<BoardView> {
  late Board board;

  @override
  void initState() {
    super.initState();
    board = Board();
  }

  void updatePlayingCardDeckView() {
    setState(() {});
  }

  void testIfFinish() {
    if (board.testIfFinish()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const VictoryView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingVertical = (MediaQuery.of(context).size.height) * 0.1;
    double paddingHorizontal = (MediaQuery.of(context).size.width) * 0.02;

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/media/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
          child: Stack(children: [
            Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeckView(
                      board.nextCardsDeck,
                      board.displayDeck,
                      onPressedCallback: updatePlayingCardDeckView,
                    ),
                    PlayingCardDeckView(board.displayDeck),
                    ColoredStackView(
                      board.stacks,
                      testIfFinish: testIfFinish,
                    ),
                  ]),
              const SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (ColumnCard column in board.columns) ...[
                      SizedBox(
                        width: cardWidth,
                        child: ColumnCardView(column),
                      )
                    ]
                  ]),
            ]),
          ]),
        ));
  }
}
