import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/screens/board_screen/components/column_card_view.dart';
import 'package:solitaire/screens/board_screen/components/playing_card_deck_view.dart';
import 'package:solitaire/screens/board_screen/components/colored_stack_view.dart';
import 'package:solitaire/screens/board_screen/components/deck_view.dart';
import 'package:solitaire/screens/victory_screen/victory.dart';

class BoardView extends StatefulWidget {
  Board board;
  BoardView({super.key, required this.board});

  @override
  BoardViewState createState() => BoardViewState();
}

class BoardViewState extends State<BoardView> {
  // Number of move played by the player
  int counter = 0;
  bool isGameFinished = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (!isGameFinished) {
      saveGame();
    }
    super.dispose();
  }

  Future<void> saveGame() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> boardJson = widget.board.toJson();
    await prefs.setString('gameState', jsonEncode(boardJson));
  }

  void updatePlayingCardDeckView() {
    setState(() {
      counter ++;
    });
  }

  void testIfFinish() {
    if (widget.board.testIfFinish()) {
      setState(() {
        isGameFinished = true;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const VictoryView())
      );
    }
  }

  Widget build(BuildContext context) {
    double paddingVertical = (MediaQuery.of(context).size.height) * 0.1;
    double paddingHorizontal = (MediaQuery.of(context).size.width) * 0.007;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double width = screenWidth * 0.13;

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
                        nextCardsDeck: widget.board.nextCardsDeck,
                        displayDeck: widget.board.displayDeck,
                        onPressedCallback: updatePlayingCardDeckView,
                        counter: counter,
                      ),
                      PlayingCardDeckView(
                        displayDeck: widget.board.displayDeck,
                        counter: counter,
                      ),
                      SizedBox(
                        width: paddingHorizontal,
                      ),
                      ColoredStackView(
                        stacks: widget.board.stacks,
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
                      for (ColumnCard column in widget.board.columns) ...[
                        SizedBox(
                          width: width,
                          child: ColumnCardView(
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
      ),
    );
  }
}
