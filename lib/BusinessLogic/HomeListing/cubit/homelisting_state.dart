part of 'homelisting_cubit.dart';

@immutable
abstract class HomelistingState {}

class HomelistingInitial extends HomelistingState {}

class HomelistingGenerated extends HomelistingState {
  HomelistingGenerated(this.product);
  final Map product;
}
