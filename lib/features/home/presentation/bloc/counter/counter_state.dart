class CounterState {
  CounterState({required this.tappedCount});

  final int tappedCount;
}

class CounterStateInitial extends CounterState {
  CounterStateInitial({super.tappedCount = 0});
}
