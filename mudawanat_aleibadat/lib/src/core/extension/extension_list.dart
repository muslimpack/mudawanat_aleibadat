import 'dart:math';

extension ListExtension on List {
  List<T> getRandomItem<T>() {
    final Random random = Random();
    final randItemIndex = random.nextInt(length);

    return [this[randItemIndex] as T];
  }
}
