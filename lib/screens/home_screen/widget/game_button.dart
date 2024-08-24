import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/shared/widget/button.dart';

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
    return CustomButton(
      onPressed: accessToGame,
      title: widget.title,
    );
  }
}
