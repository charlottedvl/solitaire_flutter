import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';
import 'package:solitaire/shared/string_constants.dart';

class MyTitle extends StatelessWidget {
  final double widthSizedBox;
  final double heightSizedBox;

  MyTitle(
    this.widthSizedBox,
    this.heightSizedBox, {
    Key? key,
  }) : super(key: key);

  final List<String> cards = [
    "Ready",
    "To",
    "Have",
    "Fun",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (String card in cards) ...[
            if (card.isNotEmpty) ...[
              Container(
                width: 60.7, // Adjust the width and height as needed
                height: 97.1,
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
        Stack(
          children: <Widget>[
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.purple,
              ),
              child: const Text(
                WELCOME_MSG_EN,
                textAlign: TextAlign.center,
              ),
            ),
            const DefaultTextStyle(
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              child: Text(
                WELCOME_MSG_EN,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    );
  }
}
