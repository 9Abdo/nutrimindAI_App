import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:nutrimind/core/errors/error_handler.dart';
import 'package:nutrimind/core/failure/failure_app.dart';
import 'package:nutrimind/feature/Auth/data/datasource/auth_data_source_abstract.dart';
import 'package:nutrimind/feature/Auth/domain/repo/auth_repo_abstract.dart';

class AuthRepoImplemention implements AuthRepoAbstract {
  final AuthDataSourceAbstract authDataSourceAbstract;

  AuthRepoImplemention({required this.authDataSourceAbstract});
  @override
  Future<Either<FailureApp, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await authDataSourceAbstract.login(email: email, password: password);
      return Right(null);
    } catch (e, stackTrace) {
      log('LOGIN REPOSITORY ERROR: $e', error: e, stackTrace: stackTrace);
      return Left(ErrorHandler.getErrorMessage(e));
    }
  }

  @override
  Future<Either<FailureApp, void>> signUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    try {
      await authDataSourceAbstract.signUp(
        email: email,
        password: password,
        fullname: fullname,
      );
      return Right(null);
    } catch (e, stackTrace) {
      log('LOGIN REPOSITORY ERROR: $e', error: e, stackTrace: stackTrace);
      return Left(ErrorHandler.getErrorMessage(e));
    }
  }
}
