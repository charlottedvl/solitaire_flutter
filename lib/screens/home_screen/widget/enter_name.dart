import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

class EnterName extends StatelessWidget {
  const EnterName({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BoardView()));
          },
          child: const Text(
            "Start game",
            style: TextStyle(
              color: Colors.white,
            ),
            textScaleFactor: 1.5,
          ),
        ),
      ]),
    );
  }
}
