import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'selectcolor_state.dart';

class SelectcolorCubit extends Cubit<SelectcolorState> {
  final List colours;
  SelectcolorCubit(this.colours) : super(SelectcolorInitial(colours[0], 0));

  void OnColorClick(Map colour, int index) {
    emit(SelectcolorInitial(colour, index));
  }
}
