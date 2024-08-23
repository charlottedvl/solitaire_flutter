import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  ToolBar({super.key, required this.cancelMove});
  Function cancelMove;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          cancelMove();
        },
        child: const Text("Undo"));
  }
}
