import 'package:flutter/material.dart';
import 'package:solitaire/backend/board.dart';
import 'package:solitaire/screens/board_screen/widget/column_card_view.dart';
import 'package:solitaire/screens/board_screen/widget/playing_card_deck_view.dart';
import 'package:solitaire/screens/board_screen/widget/colored_stack_view.dart';
import 'package:solitaire/screens/board_screen/widget/deck_view.dart';

class BoardView extends StatelessWidget {
  Board board;

  BoardView(this.board, {
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    double paddingVertical = (MediaQuery.of(context).size.height) * 0.1;
    double paddingHorizontal = (MediaQuery.of(context).size.width) * 0.02;
    int numberColumn = 7;

    return Container (
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/media/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child : Padding(
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
          child : Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeckView(),
                    const PlayingCardDeckView(),
                    ColoredStackView(),
                  ]
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < numberColumn; i++) ...[
                  const SizedBox(
                      width:50,
                      child : ColumnCardView()
                  )
                ]
              ]
          ),
          ]
          ),
        )
    );
  }
}