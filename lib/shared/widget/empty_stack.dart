import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';

class EmptyStack extends StatelessWidget {
  String? icon;

  EmptyStack({
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = originalCardWidth / originalCardHeight;

    final double screenWidth = MediaQuery.of(context).size.width;

    final double width = screenWidth * 0.13;
    final double height = width / aspectRatio;
    return Opacity(
      opacity: opacityEmptyStack,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: icon != null
              ? DecorationImage(
                  image: AssetImage('assets/images/media/cardView/$icon.png'),
                  fit: BoxFit.cover,
                )
              : null,
          border: Border.all(
            color: Colors.white,
            width: emptyStackBorderWidth,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(cardRadius),
          ),
        ),
      ),
    );
  }
}
