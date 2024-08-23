import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';
import 'package:solitaire/screens/home_screen/widget/title.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  double padding = 0.1;
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;

  void calculateSize(double screenWidth, double screenHeight) {
    padding = screenWidth * 0.1;
    widthSizedBox = screenWidth * 0.02;
    heightSizedBox = screenHeight * 0.05;
  }

  Future<Board> loadGame() async {
    Board board;
    final prefs = await SharedPreferences.getInstance();
    String? savedBoard = prefs.getString('gameState');
    if (savedBoard != null) {
      board = Board.fromJson(jsonDecode(savedBoard));
    } else {
      board = Board(false, null, null, null, null, null);
    }
    return board;
  }

  Future<Widget> playButton(BuildContext context, String title) async {
    Board board = await loadGame();
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BoardView(board: board)));
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
            textScaleFactor: 1.5,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    calculateSize(screenWidth, screenHeight);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTitle(widthSizedBox, heightSizedBox),
          FutureBuilder<Widget>(
            future: playButton(context, "Start new game"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
