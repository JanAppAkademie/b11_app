import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterStateInitial()) {
    on<CounterIncremented>(
      (event, emit) => emit(CounterState(tappedCount: state.tappedCount + 1)),
    );
    on<CounterDecremented>(
      (event, emit) => emit(CounterState(tappedCount: state.tappedCount - 1)),
    );
    on<CounterCoolEvent>((event, emit) => emit(CounterStateInitial()));
  }
}
