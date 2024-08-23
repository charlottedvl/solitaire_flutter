import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

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
    board = context.watch<BoardProvider>().board;
    return Material(
      color: Colors.transparent,
      child: Column(children: [
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
          child: Text(
            widget.title,
            style: TextStyle(
              color: (widget.isNewGameButton || board != null)
                  ? Colors.white
                  : Colors.black,
            ),
            textScaleFactor: 1.5,
          ),
        ),
      ]),
    );
  }
}
