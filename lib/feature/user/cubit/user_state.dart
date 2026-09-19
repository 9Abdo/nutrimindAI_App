import 'package:nutrimind/feature/model/user_modal.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;

  UserSuccess({required this.user});
}

class UserFailure extends UserState {
  final String error;

  UserFailure({required this.error});
}
class UserPasswordChanged extends UserState {}
class UserPasswordLoading extends UserState{}
class UserNameLoading extends UserState {}

class UserNameChanged extends UserState {}