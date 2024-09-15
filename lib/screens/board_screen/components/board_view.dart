import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/models/colum_card.dart';
import 'package:solitaire/backend/providers/board_provider.dart';
import 'package:solitaire/screens/board_screen/components/column_card_view.dart';
import 'package:solitaire/screens/board_screen/components/playing_card_deck_view.dart';
import 'package:solitaire/screens/board_screen/components/colored_stack_view.dart';
import 'package:solitaire/screens/board_screen/components/deck_view.dart';

class BoardView extends StatefulWidget {
  Board board;
  final Function(bool) onTestResult;
  BoardView({required Key key, required this.board, required this.onTestResult})
      : super(key: key);

  @override
  BoardViewState createState() => BoardViewState();
}

class BoardViewState extends State<BoardView> {
  // Number of move played by the player
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
    setState(() {
      boardProvider = context.read<BoardProvider>();
    });
    super.didChangeDependencies();
  }

  void saveMove() {
    context.read<BoardProvider>().increaseCounterMoves();
    setState(() {
      Map<String, dynamic> boardMap =
          board.toJson(boardProvider.elapsedSeconds);
      board.previousBoard = boardMap;
    });
    testIfAutocomplete();
  }

  void testIfFinish() {
    if (board.testIfFinish()) {
      setState(() {
        isGameFinished = true;
      });
      Navigator.pushReplacementNamed(context, '/victory');
    }
  }

  void testIfAutocomplete() {
    if (board.testIfAutocomplete()) {
      widget.onTestResult(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingVertical = (MediaQuery.of(context).size.height) * 0.01;
    double paddingHorizontal = (MediaQuery.of(context).size.width) * 0.007;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double width = screenWidth * 0.13;
    return Padding(
        padding: EdgeInsets.only(
          top: paddingVertical,
          left: paddingHorizontal,
          right: paddingHorizontal,
        ),
        child: Column(children: [
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
                        counter: board.moves,
                        saveMove: saveMove),
                    PlayingCardDeckView(
                      displayDeck: board.displayDeck,
                      counter: board.moves,
                      saveMove: saveMove,
                    ),
                    SizedBox(
                      width: paddingHorizontal,
                    ),
                    ColoredStackView(
                      stacks: board.stacks,
                      saveMove: saveMove,
                      testIfFinish: testIfFinish,
                      counter: board.moves,
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
                          counter: board.moves,
                        ),
                      )
                    ]
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
