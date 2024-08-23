import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';
import 'package:solitaire/screens/home_screen/widget/continue_game_button.dart';
import 'package:solitaire/screens/home_screen/widget/new_game_button.dart';
import 'package:solitaire/screens/home_screen/widget/title.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  double padding = 0.1;
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;
  Board board = Board(false, null, null, null, null, null);

  void calculateSize(double screenWidth, double screenHeight) {
    padding = screenWidth * 0.1;
    widthSizedBox = screenWidth * 0.02;
    heightSizedBox = screenHeight * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    context.read<BoardProvider>().loadGame();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    calculateSize(screenWidth, screenHeight);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTitle(widthSizedBox, heightSizedBox),
          const NewGameButton(
            title: "Start new game",
          ),
          const ContinueGameButton(
            title: "Continue game",
          )
        ],
      ),
    );
  }
}
