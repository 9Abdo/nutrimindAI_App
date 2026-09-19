import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/feature/Auth/cubit/auth_state.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitStateAuth());

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;

      if (user == null) {
        emit(LoginFailure(error: "auth.errors.login_failed"));
        return;
      }

      if (!user.emailVerified) {
        await auth.signOut();

        emit(LoginFailure(error: "auth.errors.email_not_verified_error"));

        return;
      }

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        emit(LoginFailure(error: "auth.errors.invalid_credential"));
      } else if (e.code == "user-not-found") {
        emit(LoginFailure(error: "auth.errors.user_not_found"));
      } else if (e.code == "wrong-password") {
        emit(LoginFailure(error: "auth.errors.wrong_password"));
      } else if (e.code == "invalid-email") {
        emit(LoginFailure(error: "auth.errors.invalid_email"));
      } else {
        emit(LoginFailure(error: e.message ?? "auth.errors.login_failed"));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    emit(SignUpLoading());

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;

      if (user == null) {
        emit(SignUpFailure(error: "auth.errors.signup_failed"));
        return;
      }

      await user.sendEmailVerification();

      await FirestoreServices().saveUser(
        uid: user.uid,
        fullname: fullname.trim(),
        email: email.trim(),
      );

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(error: 'auth.errors.weak_password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(error: 'auth.errors.email_already_in_use'));
      } else if (e.code == 'invalid-email') {
        emit(SignUpFailure(error: 'auth.errors.invalid_email'));
      } else {
        emit(SignUpFailure(error: e.message ?? 'auth.errors.login_failed'));
      }
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  Future<bool> checkEmailVerified() async {
    final user = auth.currentUser;

    if (user == null) {
      return false;
    }

    await user.reload();

    final updatedUser = auth.currentUser;

    return updatedUser?.emailVerified ?? false;
  }

  Future<void> resendVerificationEmail() async {
    final user = auth.currentUser;

    if (user == null) {
      return;
    }

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
