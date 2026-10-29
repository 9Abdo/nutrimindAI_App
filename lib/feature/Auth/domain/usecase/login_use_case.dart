import 'package:dartz/dartz.dart';
import 'package:nutrimind/core/failure/failure_app.dart';
import 'package:nutrimind/feature/Auth/domain/repo/auth_repo_abstract.dart';

class LoginUseCase {
  final AuthRepoAbstract authRepoAbstract;

  LoginUseCase({required this.authRepoAbstract});
  Future<Either<FailureApp, void>> invoke({
    required String email,
    required String password,
  }) => authRepoAbstract.login(email: email, password: password);
}
