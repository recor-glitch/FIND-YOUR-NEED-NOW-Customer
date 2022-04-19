import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoecommerce/Infrastructure/userfcade.dart';
import 'package:demoecommerce/constants.dart';
import 'package:demoecommerce/screens/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ImagePicker picker = ImagePicker();
  late XFile _image;
  String imgUrl = "";
  UserFcade fcade = UserFcade();
  ProfileCubit() : super(ProfileLoading()) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var data = value.data() as Map;
      if (data['profile'] != '') {
        emit(ProfileLoaded(data['profile']));
      } else {
        emit(ProfileLoaded(dummyProfile));
      }
    });
  }

  Future<void> get_image(photoprovider mode) async {
    final picked;
    if (mode == photoprovider.camera) {
      picked = await picker.pickImage(source: ImageSource.camera);
    } else {
      picked = await picker.pickImage(source: ImageSource.gallery);
    }
    try {
      _image = XFile(picked!.path);
      imgUrl = _image.path;
    } catch (e) {}
    if (imgUrl != "") {
      emit(ProfileLoading());
      await fcade.ProfileUpload(_image);
      var d_data = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var data = d_data.data() as Map;
      emit(ProfileLoaded(data['profile']));
    }
  }

  Future<void> RemovePhoto() async {
    emit(ProfileLoading());
    await fcade.RemoveProfile();
    emit(ProfileLoaded(dummyProfile));
  }
}
