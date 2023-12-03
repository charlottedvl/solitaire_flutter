import 'package:flutter/material.dart';
import 'package:solitaire/screens/home_screen/widget/enter_name.dart';
import 'package:solitaire/screens/home_screen/widget/title.dart';
import 'package:solitaire/shared/string_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    double screenHeight = (MediaQuery.of(context).size.height);
    calculateSize(screenWidth, screenHeight);
    return Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyTitle(widthSizedBox, heightSizedBox),
              const EnterName()
            ]));
  }
}
