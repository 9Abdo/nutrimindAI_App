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
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        emit(LoginFailure(error: "Email or password is incorrect."));
      } else {
        emit(LoginFailure(error: e.message ?? "Login failed."));
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
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await FirestoreServices().saveUser(
        uid: auth.currentUser!.uid,
        fullname: fullname,
        email: email.trim(),
      );
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignUpFailure(error: 'The account already exists for that email.'),
        );
      }
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }
}
