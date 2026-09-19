import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nutrimind/feature/model/user_modal.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';
import 'package:nutrimind/feature/user/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final FirestoreServices firestoreServices = FirestoreServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  StreamSubscription<UserModel?>? _userSubscription;

  UserModel? userModel;
  void getUser({bool showLoading = true}) {
    final user = auth.currentUser;

    if (user == null) {
      emit(UserFailure(error: "auth.errors.user_not_logged_in"));
      return;
    }

    _userSubscription?.cancel();

    if (showLoading) {
      emit(UserLoading());
    }

    _userSubscription = firestoreServices
        .getUser(user.uid)
        .listen(
          (userData) {
            if (userData == null) {
              emit(UserFailure(error: "auth.errors.user_data_not_found"));
              return;
            }

            userModel = userData;

            emit(UserSuccess(user: userData));
          },
          onError: (error) {
            emit(UserFailure(error: error.toString()));
          },
        );
  }

  Future<void> updatefullname({required String fullName}) async {
    final user = auth.currentUser;

    try {
      emit(UserNameLoading());
      await Future.delayed(Duration(seconds: 1));
      await firestoreServices.updatefullname(fullName, user!.uid);

      emit(UserNameChanged());
      getUser(showLoading: false);
    } catch (e) {
      emit(UserFailure(error: "profile.errors.name_update_failed"));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = auth.currentUser;

    if (user == null) {
      emit(UserFailure(error: "auth.errors.user_not_logged_in"));
      return;
    }

    if (user.email == null) {
      emit(UserFailure(error: "auth.errors.user_email_not_found"));
      return;
    }

    try {
      emit(UserPasswordLoading());

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      emit(UserPasswordChanged());

      getUser(showLoading: false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        emit(UserFailure(error: "auth.errors.old_password_incorrect"));
      } else if (e.code == 'weak-password') {
        emit(UserFailure(error: "auth.errors.new_password_weak"));
      } else if (e.code == 'requires-recent-login') {
        emit(UserFailure(error: "auth.errors.recent_login_required"));
      } else {
        emit(UserFailure(error: "auth.errors.password_change_failed"));
      }
    } catch (e) {
      emit(UserFailure(error: "auth.errors.password_change_failed"));
    }
  }
  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
