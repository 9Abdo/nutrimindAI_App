abstract class AuthState {}

class InitStateAuth extends AuthState {}

//=======================Sign up====================
class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String error;

  SignUpFailure({required this.error});
}
//=======================Log in====================
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({required this.error});
}
