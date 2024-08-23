import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/home_screen/widget/navigation_button.dart';
import 'package:solitaire/screens/home_screen/widget/title.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  double padding = 0.1;
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;
  double heightSpacing = 0.1;
  Board board = Board(false, null, null, null, null, null, null);

  void calculateSize(double screenWidth, double screenHeight) {
    padding = screenWidth * 0.1;
    widthSizedBox = screenWidth * 0.02;
    heightSizedBox = screenHeight * 0.05;
    heightSpacing = screenHeight * 0.03;
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
          Column(
            children: [
              NavigationButton(
                title: "Start new game",
                isNewGameButton: true,
              ),
              SizedBox(
                height: heightSpacing,
              ),
              NavigationButton(
                title: "Continue game",
                isNewGameButton: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
