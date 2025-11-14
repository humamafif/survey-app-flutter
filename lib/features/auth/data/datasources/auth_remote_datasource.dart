import 'dart:math';
import 'package:flutter/services.dart';
import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRemoteDatasource {
  Future<void> signOut();
  Future<UserModel?> getCurrent();
  Future<UserModel> signInWithGoogle();
  Future<void> saveUserData(UserModel user);
  Future<UserModel?> getDetailUser(String studentEmail);
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
      print("✅ Login Google berhasil untuk: $email");
      try {
        final existingUser = await getDetailUser(email);
        if (existingUser != null) {
          print("✅ User sudah terdaftar ${existingUser.email}");
          return existingUser;
        } else {
          print("⚠️ User belum terdaftar, akan save data user baru");
          UserModel newUser = UserModel(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
          );
          await saveUserData(newUser);
          final savedUser = await getDetailUser(newUser.email!);
          if (savedUser == null) {
            throw Exception(
              "User berhasil disimpan tapi tidak dapat diambil dari database",
            );
          }
          return savedUser;
        }
      } catch (e) {
        print("⚠️ Error saat cek/save user di database: $e");
        throw Exception('Error while checking or saving user data: $e');
      }
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('✅ Data user berhasil disimpan!');
      }
    } on DioException catch (e) {
      print('❌ DioException saat menyimpan data user: ${e.message}');
      throw Exception('Failed to save user data: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error in saveUserData: $e');
      throw Exception("Failed to save user data: $e");
    }
  }

  @override
  Future<UserModel?> getDetailUser(String studentEmail) async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/users/email/$studentEmail',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        final userData = response.data['data'];
        print("✅ User ditemukan di database: $studentEmail");
        return UserModel.fromJson(userData);
      } else {
        print("⚠️ User tidak ditemukan di database: $studentEmail");
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print("⚠️ User tidak ditemukan di database: $studentEmail");
        return null;
      }
      print("❌ Error saat mencari user: ${e.message}");
      throw Exception('Failed to fetch user details: ${e.message}');
    } catch (e) {
      print("❌ Unexpected error in getDetailUser: $e");
      throw Exception('Unexpected error in getDetailUser: $e');
    }
  }
}
