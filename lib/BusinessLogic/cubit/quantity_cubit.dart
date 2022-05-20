import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_state.dart';

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(QuantityInitial(1));

  void IncrementCount(int count) {
    if(count < 10) {
      emit(QuantityInitial(count + 1));
    }
  }

  void DecrementCount(int count) {
    if(count != 1) {
      emit(QuantityInitial(count - 1));
    }
  }
}
