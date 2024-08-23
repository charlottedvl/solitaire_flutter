import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

class NewGameButton extends StatefulWidget {
  const NewGameButton({super.key, required this.title});

  final String title;

  @override
  State<NewGameButton> createState() => NewGameButtonState();
}

class NewGameButtonState extends State<NewGameButton> {
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
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            context.read<BoardProvider>().clearSavedGame();
            startNewGame(context);
          },
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
            textScaleFactor: 1.5,
          ),
        ),
      ]),
    );
  }
}
