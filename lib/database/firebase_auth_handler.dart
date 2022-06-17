import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHandler {
  Future<String> signUp(String email, String password) async {
    try {
      //TODO: save credential to local database
      //TODO: create firebase storage
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      return (e.toString());
    }
    return 'Something went wrong';
  }

  Future<String> signIn(String email, String password) async {
    try {
      //TODO: save credential to local database
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    } catch (e) {
      return (e.toString());
    }
    return 'Something went wrong';
  }

  Future<UserCredential> signInGoogle() async {
    //TODO: save credential to local database
    //TODO: create firebase storage

    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'test@gmail.com'});
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<UserCredential?> signInFacebook() async {
    //TODO: save credential to local database
    //TODO: create firebase storage
    if (kIsWeb) {
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    } else {
      print('START');
      final LoginResult loginResult = await FacebookAuth.instance.login();
      print('1');
      if (loginResult.status == LoginStatus.success) {
        print('3');
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        return FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteUser(User user) async {
    await user.delete();
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> sendPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUserPassword(User user, String password) async {
    await user.updatePassword(password);
  }

  Future<void> updateUserEmail(User user, String email) async {
    await user.updateEmail(email);
  }

  Future<void> reauth(User user, AuthCredential credential) async {
    await user.reauthenticateWithCredential(credential);
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  bool getUserEmailVerificationStatus(User user) {
    return user.emailVerified;
  }
}
