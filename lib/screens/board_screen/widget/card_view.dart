import 'package:flutter/material.dart';
import 'package:solitaire/backend/playing_card.dart';

class CardView extends StatelessWidget {
  PlayingCard card;

  CardView(this.card, {
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    String media = card.getMedia();
    return SizedBox(
      width: 49.22,
      height: 78.67,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/media/cardView/$media.png"),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}