import 'package:flutter/material.dart';
import 'package:solitaire/backend/colored_stack.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/screens/board_screen/widget/card_view.dart';

class ColoredStackView extends StatefulWidget {
  List<ColoredStack> stacks;

  ColoredStackView(this.stacks, {super.key});

  @override
  ColoredStackViewState createState() => ColoredStackViewState();
}

class ColoredStackViewState extends State<ColoredStackView> {
  late List<ColoredStack> stacks;

  @override
  void initState() {
    super.initState();
    stacks = widget.stacks;
  }

  @override
  Widget build(BuildContext context) {
    double height = 79.0;
    double width = 50.0;

    return Row(children: [
      for (ColoredStack stack in stacks) ...[
        SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/media/cardView/UnderStack.png"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
              for (PlayingCard card in stack.getStack()) ...[
                card.isVisible
                    ? Draggable<PlayingCard>(
                  data: card,
                  dragAnchorStrategy: pointerDragAnchorStrategy,
                  onDragCompleted: () {
                    stack.pop();
                    stack.testIfEmpty();
                    setState(() {

                    });
                  },
                  feedback: CardView(card: card),
                  child: CardView(card: card),
                )
                    : CardView(card: card)
              ],
              DragTarget(
                onWillAccept: (card) => stack.isCardAddable(card),
                onAccept: (card) => {
                  stack.push(card),
                  setState(() {

                  }),
                },
                builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                    ) {
                  return const SizedBox(
                    width: 50,
                    height: 79,
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
