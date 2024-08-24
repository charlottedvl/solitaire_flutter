import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';

class CustomTitle extends StatelessWidget {
  double widthSizedBox = 0.1;
  double heightSizedBox = 0.1;
  String title;

  CustomTitle(
    this.title,
    this.cards, {
    Key? key,
  }) : super(key: key);

  List<String> cards = [
    "Ready",
    "To",
    "Have",
    "Fun",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const double aspectRatio = originalCardWidth / originalCardHeight;
    double cardWidth = screenWidth * 0.18;
    double cardHeight = cardWidth / aspectRatio;
    widthSizedBox = screenWidth * 0.02;
    heightSizedBox = screenHeight * 0.05;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (String card in cards) ...[
            if (card.isNotEmpty) ...[
              Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/media/cardView/$card.png"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.black),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(cardRadius),
                  ),
                ),
              ),
              SizedBox(
                width: widthSizedBox,
              ),
            ],
          ],
        ]),
        SizedBox(
          height: heightSizedBox,
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge ?? TextStyle(),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
