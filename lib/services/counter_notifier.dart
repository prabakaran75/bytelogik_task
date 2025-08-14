import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.value);

  void increment() => state++;

  void decrement() => state--;

  void reset() => state = 0;
}

final initialCounterValue = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier(0);
});
