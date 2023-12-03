import 'package:flutter/material.dart';

class FinishPopUp extends StatefulWidget {
  Function refreshGame;

  FinishPopUp({
    super.key,
    required this.refreshGame,
  });

  @override
  FinishPopUpState createState() => FinishPopUpState();
}

class FinishPopUpState extends State<FinishPopUp> {
  // Show pop up if true
  static bool showPopUp = false;

  @override
  Widget build(BuildContext context) {
    return showPopUp
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Victory !",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.refreshGame();
                  },
                  child: const Text(
                    "Play again",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.2,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
