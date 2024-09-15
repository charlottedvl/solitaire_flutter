import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/screens/board_screen/components/board_view.dart';
import 'package:solitaire/screens/board_screen/components/info_bar.dart';
import 'package:solitaire/screens/board_screen/components/tool_bar.dart';
import 'package:solitaire/screens/shared/widget/button.dart';
import 'package:solitaire/shared/constants.dart';

class BoardScreen extends StatefulWidget {
  Board board;

  BoardScreen({super.key, required this.board});
  @override
  State<BoardScreen> createState() => BoardScreenState();
}

class BoardScreenState extends State<BoardScreen> {
  late Board board;
  int counterMoves = 0;
  Key boardKey = UniqueKey();
  bool isAutocomplete = false;

  @override
  void initState() {
    board = widget.board;
    super.initState();
  }

  void handleTestResult(bool result) {
    setState(() {
      isAutocomplete = result;
    });
  }

  void cancelMove() {
    context.read<BoardProvider>().increaseCounterMoves();
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
      showSnackBar();
      print("no previous move");
    }
  }

  void playAgain() {
    context.read<BoardProvider>().reinitializeCounterMoves();
    setState(() {
      board = Board(false, null, null, null, null, null, null, null);
      boardKey = UniqueKey();
    });
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          "No previous moves",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      backgroundColor: green,
      duration: const Duration(milliseconds: 300),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/media/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoBar(),
                Expanded(
                  child: BoardView(
                    key: boardKey,
                    board: board,
                    onTestResult: handleTestResult,
                  ),
                ),
              ],
            ),
          ),
          isAutocomplete
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height * 0.01),
                      child: CustomButton(
                        width: 0.8,
                        onPressed: () => {
                          Navigator.pushReplacementNamed(context, '/victory')
                        },
                        title: "Skip to victory screen",
                      )))
              : Container(),
        ],
      ),
      bottomNavigationBar: ToolBar(
        cancelMove: cancelMove,
        playAgain: playAgain,
      ),
    );
  }
}
