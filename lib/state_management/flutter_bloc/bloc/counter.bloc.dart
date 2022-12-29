// Events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

// State
abstract class CounterState {
  final int counter;

  const CounterState({required this.counter});
}

class CounterInitialState extends CounterState {
  const CounterInitialState() : super(counter: 0);
}

// Response to events
class CounterStateSuccess extends CounterState {
  const CounterStateSuccess({required int counter}) : super(counter: counter);
}

class CounterStateError extends CounterState {
  final String errorMessage;
  const CounterStateError(this.errorMessage, {required int counter})
      : super(counter: counter);
}

// Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on<IncrementEvent>((event, emit) {
      if (state.counter < 10) {
        int newValueOfCounter = state.counter + 1;
        emit(CounterStateSuccess(counter: newValueOfCounter));
      } else {
        emit(CounterStateError('Counter cannot be greater than 10',
            counter: state.counter));
      }
    });
    on<DecrementEvent>((event, emit) {
      if (state.counter > 0) {
        int newValueOfCounter = state.counter - 1;
        emit(CounterStateSuccess(counter: newValueOfCounter));
      } else {
        emit(CounterStateError('Counter cannot be less than 0',
            counter: state.counter));
      }
    });
  }
}
