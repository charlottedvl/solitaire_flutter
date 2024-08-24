import 'package:flutter/material.dart';
import 'package:solitaire/screens/shared/widget/nav_bar.dart';
import 'package:solitaire/shared/constants.dart';

class TitleButtonScreen extends StatelessWidget {
  List<Widget> widgets;
  double verticalPadding = 0.1;
  double horizontalPadding = 0.1;
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;
  double heightSpacing = 0.1;
  double cardWidth = 0.1;
  double cardHeight = 0.1;
  int? selectedIndex;

  TitleButtonScreen({super.key, required this.widgets, this.selectedIndex});

  void calculateSize(double screenWidth, double screenHeight) {
    horizontalPadding = screenWidth * 0.07;
    verticalPadding = screenHeight * 0.3;
    heightSpacing = screenHeight * 0.02;
  }

  @override
  Widget build(BuildContext context) {
    calculateSize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);
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
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgets),
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
      ),
    );
  }
}
