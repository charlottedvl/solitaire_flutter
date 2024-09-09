import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/home_screen/widget/game_button.dart';
import 'package:solitaire/screens/shared/screen_shape/title_button_screen.dart';
import 'package:solitaire/shared/string_constants.dart';
import 'package:solitaire/screens/shared/widget/custom_title.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  Board board = Board(false, null, null, null, null, null, null, null);
  int selectedIndex = 0;
  List<String> cards = [
    "Ready",
    "To",
    "Have",
    "Fun",
  ];

  List<Widget> getWidgets() {
    return [
      CustomTitle(WELCOME_MSG_EN, cards),
      Column(
        children: [
          GameButton(
            title: "Start new game",
            isNewGameButton: true,
          ),
          SizedBox(
            height: 10,
          ),
          GameButton(
            title: "Continue game",
            isNewGameButton: false,
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    context.read<BoardProvider>().loadGame();
    List<Widget> widgets = getWidgets();
    return TitleButtonScreen(widgets: widgets, selectedIndex: selectedIndex);
  }
}
