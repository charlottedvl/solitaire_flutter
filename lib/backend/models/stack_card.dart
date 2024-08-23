abstract class StackCard<T> {
  List<T> stack = <T>[];

  int get length => stack.length;

  bool isCardAddable(List<T> cards);

  bool canPop() => stack.isNotEmpty;

  List<T> getStack() {
    return stack;
  }

  void push(T card) {
    stack.add(card);
  }

  T? pop() {
    if (canPop()) {
      T lastCard = stack.last;
      stack.removeLast();
      return lastCard;
    }
    return null;
  }

  T peak() => stack.last;
}
