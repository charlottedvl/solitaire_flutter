import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/colored_stack.dart';
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/backend/column_draggable_card.dart';
import 'package:solitaire/backend/column_hidden_card.dart';
import 'package:solitaire/backend/playing_card.dart';

class Board {
  List<ColorCard> colors = <ColorCard>[];

  List<PlayingCard> nextCardsDeck = <PlayingCard>[];
  List<PlayingCard> discardDeck = <PlayingCard>[];

  List<ColoredStack> stacks =
      List<ColoredStack>.generate(4, (index) => ColoredStack(<PlayingCard>[]));

  List<ColumnCard> columns =
      List<ColumnCard>.generate(7, (index) => ColumnCard(ColumnDraggableCard(<PlayingCard>[]), ColumnHiddenCard(<PlayingCard>[])));

  Board() {
    // Initialize the colors
    ColorCard club = ColorCard(Colors.black, ColorCardName.Club);
    ColorCard diamonds = ColorCard(Colors.red, ColorCardName.Diamonds);
    ColorCard spade = ColorCard(Colors.black, ColorCardName.Spade);
    ColorCard heart = ColorCard(Colors.red, ColorCardName.Heart);
    colors.addAll([club, diamonds, spade, heart]);

    // Initialize the 52 cards deck
    for (ColorCard color in colors) {
      String colorName = color.getColorCardName();
      for (int i = 1; i < 14; i++) {
        nextCardsDeck.add(PlayingCard(i, color, "$i$colorName"));
      }
    }

    // Initialize the columns
    final random = Random();
    int index;
    for (int indexColumn = 0; indexColumn < 7; indexColumn++) {
      for (int numberOfCards = 0;
          numberOfCards < indexColumn ;
          numberOfCards++) {
        index = random.nextInt(nextCardsDeck.length);
        columns[indexColumn].columnHiddenCard.push(nextCardsDeck.removeAt(index));
      }
      index = random.nextInt(nextCardsDeck.length);
      columns[indexColumn].columnDraggableCard.push(nextCardsDeck.removeAt(index));
      columns[indexColumn].columnDraggableCard.getStack().last.setIsVisible(true);
    }

    // Shuffle the deck with the remaining cards
    nextCardsDeck.shuffle();
  }

  List<ColorCard> getColors() {
    return colors;
  }

  List<PlayingCard> getNextCardsDeck() {
    return nextCardsDeck;
  }

  List<ColoredStack> getStacks() {
    return stacks;
  }

  List<ColumnCard> getColumns() {
    return columns;
  }

}
