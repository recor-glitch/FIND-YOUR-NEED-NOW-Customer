part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileLoaded extends ProfileState {
  final String img;
  ProfileLoaded(this.img);
}

class ProfileLoading extends ProfileState {}
