import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Either<AuthCredential, String>> GetGoogleCredential() async {
  try {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleauth =
        await googleuser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleauth?.idToken, accessToken: googleauth?.accessToken);
    return Left(credential);
  } on FirebaseAuthException catch (exception) {
    return Right(exception.code.replaceAll('-', ' '));
  }
}

Future<Either<OAuthCredential, String>> GetFacebookCredential() async {
  try {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
    } else {
      return Right(result.message!);
    }
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    return Left(facebookAuthCredential);
  } on FirebaseAuthException catch (exception) {
    return Right(exception.code.replaceAll('-', ' '));
  }
}

// Future<Either<AuthCredential, String>> GetTwitterCredential() async {
//   try {
//     final twitterLogin = TwitterLogin(
//         apiKey: twitterapiKey,
//         apiSecretKey: twitterapiSecretKey,
//         redirectURI: twitterredirectURI);
//     final authResult = await twitterLogin.login();

//     switch (authResult.status) {
//       case TwitterLoginStatus.loggedIn:
//         final AuthCredential twitterAuthCredential =
//             TwitterAuthProvider.credential(
//                 accessToken: authResult.authToken!,
//                 secret: authResult.authTokenSecret!);

//         return Left(twitterAuthCredential);
//       default:
//         return const Right('Failed to connect with twitter.');
//     }
//   } on FirebaseAuthException catch (exception) {
//     return Right(exception.code.replaceAll('-', ' '));
//   }
// }
