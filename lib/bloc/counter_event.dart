part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent({required this.value});
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent({required String value}) : super(value: value);
}


class DecrementEvent extends CounterEvent {
  const DecrementEvent({required String value}) : super(value: value);
}