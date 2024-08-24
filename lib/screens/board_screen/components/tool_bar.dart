import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/widgets/tool_bar_button.dart';
import 'package:solitaire/shared/constants.dart';

class ToolBar extends StatelessWidget {
  ToolBar({super.key, required this.cancelMove, required this.saveGame});
  Function cancelMove;
  Function saveGame;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: lightGreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToolBarButton(
            action: () => {},
            label: "Home",
            icon: const Icon(Icons.home),
          ),
          ToolBarButton(
            action: () => {},
            label: "Hint",
            icon: const Icon(Icons.lightbulb),
          ),
          ToolBarButton(
            action: () => {},
            label: "Play",
            icon: const Icon(Icons.replay),
          ),
          ToolBarButton(
            action: cancelMove,
            label: "Undo",
            icon: const Icon(Icons.reply),
          ),
          ToolBarButton(
            action: () => {},
            label: "Settings",
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );

    /*
      ElevatedButton(
        onPressed: () {
          cancelMove();
        },
        child: const Text("Undo"));

       */
  }
}
