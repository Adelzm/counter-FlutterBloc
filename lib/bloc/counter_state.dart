part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  final int number;
  const CounterState({required this.number});
}

class CounterStateValidNumber extends CounterState {
  const CounterStateValidNumber({required int number}) : super(number: number);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidNumber;
  const CounterStateInvalidNumber({required this.invalidNumber, required int previousNumber})
      : super(number: previousNumber);
}


