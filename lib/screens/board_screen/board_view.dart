import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/models/colum_card.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/components/column_card_view.dart';
import 'package:solitaire/screens/board_screen/components/playing_card_deck_view.dart';
import 'package:solitaire/screens/board_screen/components/colored_stack_view.dart';
import 'package:solitaire/screens/board_screen/components/deck_view.dart';
import 'package:solitaire/screens/victory_screen/victory.dart';

class BoardView extends StatefulWidget {
  Board board;
  BoardView({required Key key, required this.board}) : super(key: key);

  @override
  BoardViewState createState() => BoardViewState();
}

class BoardViewState extends State<BoardView> {
  // Number of move played by the player
  int counter = 0;
  bool isGameFinished = false;
  late BoardProvider boardProvider;
  late Board board;
  Key boardKey = UniqueKey();

  @override
  void dispose() {
    if (!isGameFinished) {
      boardProvider.saveGame(board);
    }
    super.dispose();
  }

  @override
  void initState() {
    board = widget.board;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    boardProvider = context.read<BoardProvider>();
  }

  void saveMove() {
    setState(() {
      counter++;
      Map<String, dynamic> boardMap = board.toJson();
      board.previousBoard = boardMap;
    });
  }

  void testIfFinish() {
    if (board.testIfFinish()) {
      setState(() {
        isGameFinished = true;
      });
      Navigator.pushReplacementNamed(context, '/victory');
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingVertical = (MediaQuery.of(context).size.height) * 0.1;
    double paddingHorizontal = (MediaQuery.of(context).size.width) * 0.007;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double width = screenWidth * 0.13;

    return Padding(
      padding: EdgeInsets.only(
        top: paddingVertical,
        left: paddingHorizontal,
        right: paddingHorizontal,
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeckView(
                        nextCardsDeck: board.nextCardsDeck,
                        displayDeck: board.displayDeck,
                        counter: counter,
                        saveMove: saveMove),
                    PlayingCardDeckView(
                      displayDeck: board.displayDeck,
                      counter: counter,
                      saveMove: saveMove,
                    ),
                    SizedBox(
                      width: paddingHorizontal,
                    ),
                    ColoredStackView(
                      stacks: board.stacks,
                      saveMove: saveMove,
                      testIfFinish: testIfFinish,
                      counter: counter,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (ColumnCard column in board.columns) ...[
                      SizedBox(
                        width: width,
                        child: ColumnCardView(
                          saveMove: saveMove,
                          column: column,
                          counter: counter,
                        ),
                      )
                    ]
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
