abstract class StackCard<PlayingCard> {
  List<PlayingCard> stack = <PlayingCard>[];

  int get length => stack.length;

  bool isCardAddable(PlayingCard card);

  bool canPop() => stack.isNotEmpty;

  List<PlayingCard> getStack() {
    return stack;
  }

  void clearStack() {
    while (stack.isNotEmpty) {
      stack.removeLast();
    }
  }

  void push(PlayingCard card) {
    stack.add(card);
  }

  PlayingCard pop() {
    PlayingCard lastCard = stack.last;
    stack.removeLast();
    return lastCard;
  }

  PlayingCard peak() => stack.last;
}
