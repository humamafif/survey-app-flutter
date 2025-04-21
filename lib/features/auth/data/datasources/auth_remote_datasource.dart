import 'dart:math';

import 'package:flutter/services.dart';
import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRemoteDatasource {
  Future<void> signOut();
  Future<UserModel?> getCurrent();
  Future<UserModel> signInWithGoogle();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDatasourceImpl({required this.auth, required this.googleSignIn});
  @override
  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Future<UserModel?> getCurrent() async {
    final user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: e.toString(),
          message: 'Google sign-in aborted',
        );
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: e.toString(),
          message: 'User not found',
        );
      }
      final email = user.email;
      if (email == null || !isValidStudentEmail(email)) {
        await FirebaseAuth.instance.currentUser?.delete();
        await auth.signOut();
        await googleSignIn.signOut();
        throw FirebaseAuthException(
          code: 'invalid-student-email',
          message: e.toString(),
        );
      }
      return UserModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on PlatformException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: 'Platform error: ${e.message}',
      );
    } catch (e) {
      throw FirebaseAuthException(code: e.toString(), message: e.toString());
    }
  }
}
