import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final List images;
  ImageCubit(this.images) : super(ImageLoaded(images[0], 0));

  void OnImgClick(String image, int index) {
    emit(ImageLoaded(image, index));
  }
}
