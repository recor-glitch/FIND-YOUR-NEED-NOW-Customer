part of 'selectcolor_cubit.dart';

@immutable
abstract class SelectcolorState {}

class SelectcolorInitial extends SelectcolorState {
  final Map colour;
  final int index;
  SelectcolorInitial(this.colour, this.index);
}
