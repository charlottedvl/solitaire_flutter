import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_screen.dart';

class GameButton extends StatefulWidget {
  GameButton({super.key, required this.title, required this.isNewGameButton});

  final String title;
  bool isNewGameButton = true;

  @override
  State<GameButton> createState() => GameButtonState();
}

class GameButtonState extends State<GameButton> {
  Board? board;

  @override
  void initState() {
    super.initState();
  }
/*
  Future<void> startNewGame() async {
    Board newBoard = Board(false, null, null, null, null, null, null);
    Navigator.pushNamed(
      context,
      '/board',
      arguments: newBoard,
    );
  }

  Future<void> continueGame() async {
    Navigator.pushNamed(
      context,
      '/board',
      arguments: board,
    );
  }

 */

  void accessToGame() {
    Board? boardToPlay;
    if (widget.isNewGameButton) {
      context.read<BoardProvider>().clearSavedGame();
      boardToPlay = Board(false, null, null, null, null, null, null);
    } else {
      if (board != null) {
        boardToPlay = board;
      } else {
        // TODO : pop up
        print("No previous game saved");
      }
    }
    Navigator.pushNamed(
      context,
      '/board',
      arguments: boardToPlay,
    );
  }

  @override
  Widget build(BuildContext context) {
    board = context.watch<BoardProvider>().board;
    return Material(
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: accessToGame,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          widget.title,
          textScaleFactor: 1.5,
        ),
      ),
    );
  }
}
