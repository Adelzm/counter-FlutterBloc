import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValidNumber(number: 0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
            invalidNumber: event.value, previousNumber: state.number));
      } else {
        emit(CounterStateValidNumber(number: state.number + integer));
      }
    });

    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
            invalidNumber: event.value, previousNumber: state.number));
      } else {
        emit(CounterStateValidNumber(number: state.number - integer));
      }
    });
  }
}
