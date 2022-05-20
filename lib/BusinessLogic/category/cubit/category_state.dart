part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailed extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final QuerySnapshot snap;
  CategoryLoaded(this.snap);
}
