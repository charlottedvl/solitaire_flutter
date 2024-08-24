import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/home_screen/widget/game_button.dart';
import 'package:solitaire/screens/home_screen/widget/nav_bar.dart';
import 'package:solitaire/screens/home_screen/widget/title.dart';
import 'package:solitaire/shared/constants.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  double padding = 0.1;
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;
  double heightSpacing = 0.1;
  Board board = Board(false, null, null, null, null, null, null);
  int selectedIndex = 0;

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

    return Scaffold(
      backgroundColor: lightGreen,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/media/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyTitle(widthSizedBox, heightSizedBox),
              Column(
                children: [
                  GameButton(
                    title: "Start new game",
                    isNewGameButton: true,
                  ),
                  SizedBox(
                    height: heightSpacing,
                  ),
                  GameButton(
                    title: "Continue game",
                    isNewGameButton: false,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
      ),
    );
  }
}
