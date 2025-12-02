abstract class CounterEvent {}

class CounterIncremented extends CounterEvent {
  CounterIncremented();
}

class CounterDecremented extends CounterEvent {
  CounterDecremented();
}

class CounterCoolEvent extends CounterEvent {
  CounterCoolEvent();
}