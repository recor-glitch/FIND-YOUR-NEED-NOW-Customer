part of 'quantity_cubit.dart';

@immutable
abstract class QuantityState {}

class QuantityInitial extends QuantityState {
  final int count;
  QuantityInitial(this.count);
}
