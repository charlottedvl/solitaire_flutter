import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/colored_stack.dart';
import 'package:solitaire/backend/models/playing_card.dart';
import 'package:solitaire/screens/board_screen/widgets/card_view.dart';
import 'package:solitaire/shared/constants.dart';
import 'package:solitaire/shared/widget/empty_stack.dart';

class ColoredStackView extends StatefulWidget {
  // Cards of a color
  List<ColoredStack> stacks;
  // Test if the game is over
  Function testIfFinish;
  // Number of move played by the player
  int counter;

  ColoredStackView({
    super.key,
    required this.stacks,
    required this.testIfFinish,
    required this.counter,
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

  void addCardsToStack(List<PlayingCard> data, ColoredStack stack) {
    setState(() {
      stack.push(data[0]);
      widget.counter++;
    });
    widget.testIfFinish();
  }

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = originalCardWidth / originalCardHeight;

    final double screenWidth = MediaQuery.of(context).size.width;

    final double width = screenWidth * 0.13;
    final double height = width / aspectRatio;

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
                    addCardsToStack(data, stack);
                  }
                },
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return SizedBox(
                    width: width,
                    height: height,
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
