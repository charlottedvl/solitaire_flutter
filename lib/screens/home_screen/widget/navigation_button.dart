import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';
import 'package:solitaire/shared/constants.dart';

class NavigationButton extends StatefulWidget {
  NavigationButton(
      {super.key, required this.title, required this.isNewGameButton});

  final String title;
  bool isNewGameButton = true;

  @override
  State<NavigationButton> createState() => NavigationButtonState();
}

class NavigationButtonState extends State<NavigationButton> {
  Board? board;

  @override
  void initState() {
    super.initState();
  }

  Future<void> startNewGame(context) async {
    Board newBoard = Board(false, null, null, null, null, null);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardView(board: newBoard)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    board = context.watch<BoardProvider>().board;
    return Material(
      color: Colors.transparent,
      child:
        ElevatedButton(
          onPressed: () {
            if (widget.isNewGameButton) {
              context.read<BoardProvider>().clearSavedGame();
              startNewGame(context);
            } else {
              if (board != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardView(
                      board:
                          board ?? Board(false, null, null, null, null, null),
                    ),
                  ),
                );
              } else {
                print("No previous game saved");
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: green,
          ),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white
            ),
            textScaleFactor: 1.5,
          ),
        ),

    );
  }
}
