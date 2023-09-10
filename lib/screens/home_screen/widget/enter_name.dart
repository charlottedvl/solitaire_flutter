import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

class EnterName extends StatelessWidget {
  const EnterName({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        const TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Your name",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(width: 3, color: Colors.purple),
              ),
            )),
        const SizedBox(height: 5),
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
