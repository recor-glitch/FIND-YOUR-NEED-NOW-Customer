import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homelisting_state.dart';

class HomelistingCubit extends Cubit<HomelistingState> {
  HomelistingCubit() : super(HomelistingInitial());

  void GenerateHomeProduct(Map product) {
    emit(HomelistingGenerated(product));
  }

  void DegenerateHomeListing() {
    emit(HomelistingInitial());
  }
}
