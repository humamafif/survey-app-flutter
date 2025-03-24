import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrent();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth auth;

  AuthRemoteDatasourceImpl({required this.auth});

  @override
  Future<UserModel> signIn(String email, String password) async {
    UserCredential credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(credential.user);
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(credential.user);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<UserModel?> getCurrent() async {
    final user = auth.currentUser; // Ambil dari FirebaseAuth
    if (user != null) {
      return UserModel.fromFirebase(user);
    }
    return null; // Jika tidak ada user, return null
  }
}
