abstract class StackCard<PlayingCard> {
  List<PlayingCard> stack = <PlayingCard>[];

  int get length => stack.length;

  bool isCardAddable(List<PlayingCard> cards);

  bool canPop() => stack.isNotEmpty;

  List<PlayingCard> getStack() {
    return stack;
  }

  void push(PlayingCard card) {
    stack.add(card);
  }

  PlayingCard? pop() {
    if (canPop()) {
      PlayingCard lastCard = stack.last;
      stack.removeLast();
      return lastCard;
    }
  }

  PlayingCard peak() => stack.last;
}
