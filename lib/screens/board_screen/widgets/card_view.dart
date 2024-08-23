import 'package:flutter/material.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/shared/constants.dart';

class CardView extends StatelessWidget {
  PlayingCard? card;
  String media = "backgroundCard";
  double opacity;

  CardView({
    this.card,
    this.opacity = 1.0,
    super.key,
  }) : media =
            card != null && card.isVisible ? card.getMedia() : "backgroundCard";

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = originalCardWidth / originalCardHeight;

    final double screenWidth = MediaQuery.of(context).size.width;

    final double width = screenWidth * 0.13;
    final double height = width / aspectRatio;
    return Opacity(
        opacity: opacity,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              if (card?.isVisible ?? false) ...[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/media/cardView/$media.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(cardRadius),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/media/cardView/$media.png"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(cardRadius),
                    ),
                  ),
                ),
              ],
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(cardRadius),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
