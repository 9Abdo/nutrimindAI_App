import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/feature/Auth/domain/usecase/login_use_case.dart';
import 'package:nutrimind/feature/Auth/domain/usecase/sign_up_use_case.dart';
import 'package:nutrimind/feature/Auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.loginUseCase, required this.signUpUseCase})
    : super(InitStateAuth());

  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  Future<void> login({required String email, required String password}) async {
    log('1. Login started');

    emit(LoginLoading());

    final loginResult = await loginUseCase.invoke(
      email: email,
      password: password,
    );

    loginResult.fold(
      (failure) {
        log('4. Login failed: ${failure.failureMessage}');
        emit(LoginFailure(error: failure.failureMessage));
      },
      (_) {
        log('4. Login success');
        emit(LoginSuccess());
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    emit(SignUpLoading());

    final signUpResult = await signUpUseCase.invoke(
      email: email,
      password: password,
      fullname: fullname,
    );

    signUpResult.fold(
      (failure) {
        emit(SignUpFailure(error: failure.failureMessage));
      },
      (_) {
        emit(SignUpSuccess());
      },
    );
  }

  Future<bool> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    await user.reload();

    return FirebaseAuth.instance.currentUser?.emailVerified ?? false;
  }

  Future<void> resendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
