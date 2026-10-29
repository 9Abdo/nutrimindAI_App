import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimind/feature/Auth/data/datasource/auth_data_source_abstract.dart';

import '../../../services/firestor_services.dart';

class RemoteAuthDataSource implements AuthDataSourceAbstract {
  final FirebaseAuth firebaseAuth;
  final FirestoreServices firestoreServices;

  RemoteAuthDataSource({
    required this.firebaseAuth,
    required this.firestoreServices,
  });
  @override
  Future<void> login({required String email, required String password}) async {
    final credential = await firebaseAuth
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .timeout(const Duration(seconds: 15));
    final user = credential.user;

    if (user == null) {
      throw FirebaseAuthException(code: 'login-failed');
    }

    if (!user.emailVerified) {
      await firebaseAuth.signOut();
      throw FirebaseAuthException(code: 'email-not-verified');
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final credential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .timeout(Duration(seconds: 15));

    final user = credential.user;

    if (user == null) {
      throw FirebaseAuthException(code: 'signup-failed');
    }

    await user.sendEmailVerification();

    await firestoreServices.saveUser(
      uid: user.uid,
      fullname: fullname.trim(),
      email: email.trim(),
    );
  }
}
