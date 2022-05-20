import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoading()) {
    FirebaseFirestore.instance
        .collection('CategoryList')
        .snapshots()
        .listen((snap) {
      if (snap.docs.isNotEmpty) {
        emit(CategoryLoaded(snap));
      } else {
        emit(CategoryFailed());
      }
    });
  }
}
