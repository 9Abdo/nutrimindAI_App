import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/feature/model/user_modal.dart';

import 'package:nutrimind/feature/profile/cubit/user_state.dart';

import 'package:nutrimind/feature/services/firestor_services.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FirestoreServices firestoreServices = FirestoreServices();

  void getUserData() {
    emit(ProfileLoading());

    final uid = FirebaseAuth.instance.currentUser!.uid;

    firestoreServices.getUser(uid).listen((doc) {
      final user = UserModel.fromJson(doc.data()!);

      emit(ProfileSuccess(user));
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}