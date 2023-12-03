import 'package:flutter/material.dart';
import 'package:solitaire/backend/colored_stack.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/shared/constants.dart';
import 'package:solitaire/shared/widget/empty_stack.dart';

class ColoredStackView extends StatefulWidget {
  // Cards of a color
  List<ColoredStack> stacks;
  // Test if the game is over
  Function testIfFinish;

  ColoredStackView(
    this.stacks, {
    super.key,
    required this.testIfFinish,
  });

  @override
  ColoredStackViewState createState() => ColoredStackViewState();
}

class ColoredStackViewState extends State<ColoredStackView> {
  // Cards of a color
  late List<ColoredStack> stacks;

  @override
  void initState() {
    super.initState();
    stacks = widget.stacks;
  }

  @override
  Widget build(BuildContext context) {
    double height = cardHeight;
    double width = cardWidth;

    return Row(children: [
      for (ColoredStack stack in stacks) ...[
        SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              EmptyStack(
                icon: "UnderStack",
              ),
              for (PlayingCard card in stack.getStack()) ...[
                card.isVisible
                    ? Draggable<List<PlayingCard>>(
                        data: [card],
                        dragAnchorStrategy: pointerDragAnchorStrategy,
                        onDragCompleted: () {
                          stack.pop();
                          stack.testIfEmpty();
                          setState(() {});
                        },
                        feedback: CardView(card: card),
                        child: CardView(card: card),
                      )
                    : CardView(card: card)
              ],
              DragTarget(
                onWillAccept: (data) {
                  if (data is List<PlayingCard>) {
                    return stack.isCardAddable(data);
                  }
                  return false;
                },
                onAccept: (data) {
                  if (data is List<PlayingCard>) {
                    stack.push(data[0]);
                    widget.testIfFinish();
                  }
                },
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return const SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    ]);
  }
}
