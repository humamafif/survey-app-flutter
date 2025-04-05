import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrent();
  Future<UserModel> signUpWithGoogle();
  Future<UserModel> signInWithGoogle();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDatasourceImpl({required this.auth, required this.googleSignIn});

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw FirebaseAuthException(code: 'unknown_error', message: e.toString());
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw FirebaseAuthException(code: 'unknown_error', message: e.toString());
    }
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

  @override
  Future<UserModel> signUpWithGoogle() async {
    return handleAuthWithGoogle(forceSignOut: true);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return handleAuthWithGoogle(forceSignOut: false);
  }

  Future<UserModel> handleAuthWithGoogle({required bool forceSignOut}) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null)
        throw FirebaseAuthException(code: 'sign_in_canceled');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) throw FirebaseAuthException(code: 'user-not-found');

      // logout
      if (forceSignOut) {
        await auth.signOut();
        await googleSignIn.signOut();
      }

      return UserModel.fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw FirebaseAuthException(code: 'unknown_error', message: e.toString());
    }
  }
}
