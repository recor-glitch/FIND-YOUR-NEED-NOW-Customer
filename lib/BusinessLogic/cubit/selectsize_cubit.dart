import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selectsize_state.dart';

class SelectsizeCubit extends Cubit<SelectsizeState> {
  final List sizes;
  SelectsizeCubit(this.sizes) : super(SelectsizeInitial(sizes[0], 0));

  void OnSizeClick(String size, int index) {
    emit(SelectsizeInitial(size, index));
  }
}
