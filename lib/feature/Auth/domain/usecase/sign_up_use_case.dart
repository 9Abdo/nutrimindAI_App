import 'package:dartz/dartz.dart';
import 'package:nutrimind/core/failure/failure_app.dart';
import 'package:nutrimind/feature/Auth/domain/repo/auth_repo_abstract.dart';

class SignUpUseCase {
  final AuthRepoAbstract authRepoAbstract;

  SignUpUseCase({required this.authRepoAbstract});
  Future<Either<FailureApp, void>> invoke({
    required String email,
    required String password,
    required String fullname,
  }) => authRepoAbstract.signUp(
    email: email,
    password: password,
    fullname: fullname,
  );
}
