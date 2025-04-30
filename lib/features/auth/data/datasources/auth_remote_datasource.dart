import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRemoteDatasource {
  Future<void> signOut();
  Future<UserModel?> getCurrent();
  Future<UserModel> signInWithGoogle();
  Future<void> saveUserData(UserModel user);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final Dio dio;

  AuthRemoteDatasourceImpl({
    required this.dio,
    required this.auth,
    required this.googleSignIn,
  });
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
      print("SIGN IN");
      print(UserModel.fromFirebase(user).toJson());

      await saveUserData(
        UserModel(uid: user.uid, email: user.email, name: user.displayName),
      );
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

  @override
  Future<void> saveUserData(UserModel user) async {
    try {
      final response = await dio.post(
        '${dotenv.env['BASE_URL']}/users',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print('DATA: ${user.toJson()}');

      if (response.statusCode != 201) {
        throw Exception('Failed to save user data');
      }
    } on DioException catch (e) {
      throw Exception('Failed to save user data: ${e.message}');
    } catch (e) {
      throw Exception("Failed to save data user: $e");
    }
  }
}
  