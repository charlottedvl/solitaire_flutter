import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/shared/widget/button.dart';
import 'package:solitaire/shared/constants.dart';

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
      context.read<BoardProvider>().reinitializeCounterMoves();
      boardToPlay = Board(false, null, null, null, null, null, null, null);
    } else {
      if (board != null) {
        boardToPlay = board;
      } else {
        showSnackBar();
      }
    }
    Navigator.pushNamed(
      context,
      '/board',
      arguments: boardToPlay,
    );
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          "No previous game",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      backgroundColor: green,
      duration: const Duration(milliseconds: 300),
    ));
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
