
import 'package:solitaire/backend/colum_card.dart';
import 'package:solitaire/backend/playing_card.dart';
import 'package:solitaire/backend/stack_card.dart';

class Board {
  Deck deck;

  StackCard<PlayingCard> stackOne;
  StackCard<PlayingCard> stackTwo;
  StackCard<PlayingCard> stackThree;
  StackCard<PlayingCard> stackFour;

  List<ColumnCards> columns;


}