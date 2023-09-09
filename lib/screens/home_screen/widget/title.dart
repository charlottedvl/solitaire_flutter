import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';

class MyTitle extends StatelessWidget {
  final double widthSizedBox;
  final double heightSizedBox;

  MyTitle(this.widthSizedBox, this.heightSizedBox, {
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
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(width: widthSizedBox,),
                ],
              ],
            ]
        ),
        SizedBox(height: heightSizedBox,),
        const Text(
            WELCOME_MSG_EN,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.purple,
              fontSize: 2.0,
            ),
            textScaleFactor: 20.0
        ),
      ],
    );
  }
}