part of 'connectioncheck_cubit.dart';

@immutable
abstract class ConnectioncheckState {}

class ConnectioncheckLoading extends ConnectioncheckState {}

class CheckDisconnected extends ConnectioncheckState {}

class CheckConnected extends ConnectioncheckState {}
