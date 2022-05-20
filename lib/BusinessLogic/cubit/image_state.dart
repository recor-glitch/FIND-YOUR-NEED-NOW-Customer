part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageLoaded extends ImageState {
  ImageLoaded(this.img, this.index);
  final String img;
  final int index;
}
