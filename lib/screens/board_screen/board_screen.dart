import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';
import 'package:solitaire/screens/board_screen/components/tool_bar.dart';

class BoardScreen extends StatefulWidget {
  Board board;

  BoardScreen({super.key, required this.board});
  @override
  State<BoardScreen> createState() => BoardScreenState();
}

class BoardScreenState extends State<BoardScreen> {
  late Board board;
  Key boardKey = UniqueKey();

  @override
  void initState() {
    board = widget.board;
    super.initState();
  }

  void cancelMove() {
    Map<String, dynamic>? previousBoard = board.previousBoard;
    if (previousBoard != null) {
      Board boardBeforeMove = Board.fromJson(previousBoard);
      setState(() {
        board = boardBeforeMove;
        boardKey = UniqueKey();
      });
      print(
          board.columns[0].columnDraggableCard.getStack()[0]?.value ?? "jkdf");
    } else {
      //TODO: pop up
      print("no previous move");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/media/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BoardView(key: boardKey, board: board),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ToolBar(
        cancelMove: cancelMove,
      ),
    );
  }
}
