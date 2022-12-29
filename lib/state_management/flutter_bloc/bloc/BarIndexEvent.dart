// Events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BarIndexEvent {}

class ChangeIndexEvent extends BarIndexEvent {
  final int currentIndex;
  ChangeIndexEvent({required this.currentIndex});
}

// State
abstract class BarIndexState {
  final int currentIndex;

  const BarIndexState({required this.currentIndex});
}

class BarIndexInitialState extends BarIndexState {
  const BarIndexInitialState() : super(currentIndex: 0);
}

// Response to events
class BarIndexStateSuccess extends BarIndexState {
  const BarIndexStateSuccess({required int currentIndex})
      : super(currentIndex: currentIndex);
}

class BarIndexStateError extends BarIndexState {
  final String errorMessage;
  const BarIndexStateError(this.errorMessage, {required int currentIndex})
      : super(currentIndex: currentIndex);
}

// Bloc
class BarIndexBloc extends Bloc<BarIndexEvent, BarIndexState> {
  BarIndexBloc() : super(const BarIndexInitialState()) {
    on<ChangeIndexEvent>((event, emit) {
      if (event.currentIndex < 0 || event.currentIndex > 7) {
        emit(BarIndexStateError('Index cannot be less than 0 or greater than 7',
            currentIndex: event.currentIndex));
      } else {
        emit(BarIndexStateSuccess(currentIndex: event.currentIndex));
      }
    });
  }
}
