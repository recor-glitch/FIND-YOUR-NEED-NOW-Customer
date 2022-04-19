import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'connectioncheck_state.dart';

class ConnectioncheckCubit extends Cubit<ConnectioncheckState> {
  Connectivity connectivity;
  ConnectioncheckCubit({required this.connectivity})
      : super(ConnectioncheckLoading()) {
    connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        emit(CheckDisconnected());
      }
    });
    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(CheckDisconnected());
      } else {
        emit(CheckConnected());
      }
    });
  }
}
