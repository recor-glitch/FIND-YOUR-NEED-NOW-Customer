part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData theme;

  ThemeLoaded(this.theme);
}

class ThemeLoading extends ThemeState {}
