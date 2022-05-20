part of 'selectsize_cubit.dart';

@immutable
abstract class SelectsizeState {}

class SelectsizeInitial extends SelectsizeState {
  SelectsizeInitial(this.size, this.index);
  final String size;
  final int index;
}
