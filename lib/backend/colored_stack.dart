

import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/color_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class ColoredStack {
  StackCard<PlayingCard> column = StackCard<PlayingCard>();

  ColorCard? color;
}