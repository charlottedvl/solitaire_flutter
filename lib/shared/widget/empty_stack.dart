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
    return Opacity(
      opacity: opacityEmptyStack,
      child: Container(
        width: cardWidth,
        height: cardHeight,
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
