import 'package:dartz/dartz.dart';
import 'package:nutrimind/core/failure/failure_app.dart';

abstract class AuthRepoAbstract {
  Future<Either<FailureApp, void>> login({
    required String email,
    required String password,
  });
  Future<Either<FailureApp, void>> signUp({
    required String email,
    required String password,
    required String fullname,
  });
}
