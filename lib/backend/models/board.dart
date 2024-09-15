import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/color_card.dart';
import 'package:solitaire/backend/models/colored_stack.dart';
import 'package:solitaire/backend/models/colum_card.dart';
import 'package:solitaire/backend/models/column_draggable_card.dart';
import 'package:solitaire/backend/models/column_hidden_card.dart';
import 'package:solitaire/backend/models/deck.dart';
import 'package:solitaire/backend/models/playing_card.dart';

class Board {
  late List<ColorCard> colors;

  // Deck of remaining card
  late Deck nextCardsDeck;
  // Display of cards (one by one or three by three)
  late Deck displayDeck;

  // List of stack to fill
  late List<ColoredStack> stacks;

  // List of the columns of cards
  late List<ColumnCard> columns;

  Map<String, dynamic>? previousBoard;

  int moves = 0;

  Board(
    bool isLoaded,
    List<ColorCard>? colors,
    Deck? nextCardsDeck,
    Deck? displayDeck,
    List<ColoredStack>? stacks,
    List<ColumnCard>? columns,
    this.previousBoard,
    int? moves,
  ) {
    if (colors != null) {
      this.colors = colors;
    } else {
      this.colors = <ColorCard>[];
      // Initialize the colors
      ColorCard club = ColorCard(Colors.black, ColorCardName.Club);
      ColorCard diamonds = ColorCard(Colors.red, ColorCardName.Diamonds);
      ColorCard spade = ColorCard(Colors.black, ColorCardName.Spade);
      ColorCard heart = ColorCard(Colors.red, ColorCardName.Heart);
      this.colors.addAll([club, diamonds, spade, heart]);
    }

    if (nextCardsDeck != null) {
      this.nextCardsDeck = nextCardsDeck;
    } else {
      this.nextCardsDeck = Deck(<PlayingCard>[], 3);
    }

    if (displayDeck != null) {
      this.displayDeck = displayDeck;
    } else {
      this.displayDeck = Deck(<PlayingCard>[], 0);
    }

    if (stacks != null) {
      this.stacks = stacks;
    } else {
      this.stacks = List<ColoredStack>.generate(
          4, (index) => ColoredStack(<PlayingCard>[], null));
    }

    if (columns != null) {
      this.columns = columns;
    } else {
      this.columns = List<ColumnCard>.generate(
          7,
          (index) => ColumnCard(ColumnDraggableCard(<PlayingCard>[]),
              ColumnHiddenCard(<PlayingCard>[])));
    }

    if (moves != null) {
      this.moves = moves;
    }

    // If the game is not loaded, then initialize the
    if (!isLoaded) {
      initializeWholeDeck();
      // Initialize the columns
      initializeColumns();
      // Shuffle the deck with the remaining cards
      this.nextCardsDeck.getStack().shuffle();
    }
  }

  void initializeWholeDeck() {
    for (ColorCard color in colors) {
      String colorName = color.getColorCardName();
      for (int i = 1; i < 14; i++) {
        nextCardsDeck.push(PlayingCard(i, color, "$i$colorName", false));
      }
    }
  }

  void initializeColumns() {
    final random = Random();
    for (int indexColumn = 0; indexColumn < 7; indexColumn++) {
      initializeOneColumn(random, indexColumn);
    }
  }

  void initializeOneColumn(Random random, int indexColumn) {
    int index;
    for (int numberOfCards = 0; numberOfCards < indexColumn; numberOfCards++) {
      index = random.nextInt(nextCardsDeck.length);
      columns[indexColumn]
          .columnHiddenCard
          .push(nextCardsDeck.getStack().removeAt(index));
    }
    index = random.nextInt(nextCardsDeck.length);
    columns[indexColumn]
        .columnDraggableCard
        .push(nextCardsDeck.getStack().removeAt(index));
    columns[indexColumn].columnDraggableCard.getStack().last.setIsVisible(true);
  }

  List<ColorCard> getColors() {
    return colors;
  }

  Deck getNextCardsDeck() {
    return nextCardsDeck;
  }

  List<ColoredStack> getStacks() {
    return stacks;
  }

  List<ColumnCard> getColumns() {
    return columns;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'colors': colors.map((colorCard) => colorCard.toJson()).toList(),
      'nextCardsDeck': nextCardsDeck.toJson(),
      'displayDeck': displayDeck.toJson(),
      'stacks': stacks.map((stack) => stack.toJson()).toList(),
      'columns': columns.map((column) => column.toJson()).toList(),
      'previousBoard': previousBoard,
      'moves': moves,
    };
    return json;
  }

  static Board fromJson(Map<String, dynamic> json) {
    List<ColorCard> colors = (json['colors'] as List)
        .map((colorJson) => ColorCard.fromJson(colorJson))
        .toList();
    Deck nextCardsDeck = Deck.fromJson(json['nextCardsDeck']);
    Deck displayDeck = Deck.fromJson(json['displayDeck']);
    List<ColoredStack> stacks = (json['stacks'] as List)
        .map((stackJson) => ColoredStack.fromJson(stackJson))
        .toList();
    List<ColumnCard> columns = (json['columns'] as List)
        .map((columnJson) => ColumnCard.fromJson(columnJson))
        .toList();
    Map<String, dynamic>? previousBoard = json['previousBoard'];
    int? moves = json['moves'];
    return Board(true, colors, nextCardsDeck, displayDeck, stacks, columns,
        previousBoard, moves);
  }

  bool testIfFinish() {
    for (ColoredStack stack in stacks) {
      if (stack.getStack().length != 13) {
        return false;
      }
    }
    return true;
  }

  bool testIfAutocomplete() {
    if ((displayDeck.length + nextCardsDeck.length) > 1 &&
        (displayDeck.length > 1 || nextCardsDeck.length > 1)) {
      return false;
    }
    for (ColumnCard columnCard in columns) {
      if (columnCard.columnHiddenCard.length > 0) {
        return false;
      }
    }
    return true;
  }
}
