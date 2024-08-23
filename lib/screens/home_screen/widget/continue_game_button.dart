import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

class ContinueGameButton extends StatefulWidget {
  const ContinueGameButton({super.key, required this.title});

  final String title;

  @override
  State<ContinueGameButton> createState() => ContinueGameButtonState();
}

class ContinueGameButtonState extends State<ContinueGameButton> {
  Board? board;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    board = context.watch<BoardProvider>().board;
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          board != null
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardView(
                          board: board ??
                              Board(false, null, null, null, null, null),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.5,
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    print("No previous game");
                  },
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    textScaleFactor: 1.5,
                  ),
                ),
        ],
      ),
    );
  }
}
