import 'dart:collection';

class StackCard<PlayingCard> {
  Queue<PlayingCard> stack = Queue<PlayingCard>();

  int get length => stack.length;

  bool canPop() => stack.isNotEmpty;

  void clearStack(){
    while(stack.isNotEmpty){
      stack.removeLast();
    }
  }

  void push(PlayingCard card) {
    stack.addLast(card);
  }

  PlayingCard pop() {
    PlayingCard lastCard = stack.last;
    stack.removeLast();
    return lastCard;
  }

  PlayingCard peak() => stack.last;

}