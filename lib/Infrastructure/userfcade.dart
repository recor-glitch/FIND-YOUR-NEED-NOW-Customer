import 'dart:io' as i;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoecommerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserFcade {
  Future<String> CreateUserWithEmailandPass(String email, String pass) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      return 'success';
    } on FirebaseAuthException catch (exception) {
      return exception.code.replaceAll('-', ' ');
    }
  }

  Future<String> StoreUserdata(String phn) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'phn': phn,
          'profile': ''
        });
        return 'success';
      } on FirebaseException catch (exception) {
        return exception.code.replaceAll('-', " ");
      }
    } else {
      return 'Not a Valid User.';
    }
  }

  Future<String> LoginWithEmailandPassword(String email, String pass) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return 'success';
    } on FirebaseAuthException catch (exception) {
      return exception.code.replaceAll('-', ' ');
    }
  }

  Future<String> SigninWithCredential(AuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return 'success';
    } on FirebaseAuthException catch (exception) {
      return exception.code.replaceAll('-', ' ');
    }
  }

  Future<String> LinkWithCredential(AuthCredential credential) async {
    try {
      await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code.replaceAll('-', ' ');
    }
  }

  Future<String> ResetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseException catch (exeption) {
      return exeption.code.replaceAll('-', ' ');
    }
  }

  Future<void> ProfileUpload(XFile img) async {
    String imgurl = "";
    Reference ref = FirebaseStorage.instance
        .ref('profilepic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    try {
      await ref.putFile(i.File(img.path));
      imgurl = await ref.getDownloadURL();
      if (imgurl != "") {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profile': imgurl});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> RemoveProfile() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'profile': ''});
    Reference ref = FirebaseStorage.instance
        .ref('profilepic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    try {
      await ref.delete();
    } catch (e) {}
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
