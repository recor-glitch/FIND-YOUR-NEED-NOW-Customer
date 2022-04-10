import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String> StoreUserdata(
      String phn) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'phn': phn
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
}
