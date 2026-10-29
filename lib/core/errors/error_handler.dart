import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../failure/failure_app.dart';

class ErrorHandler {
  static FailureApp getErrorMessage(Object error) {
    if (error is DioException) {
      return FailureApp(failureMessage: _handleDioError(error));
    }

    if (error is FirebaseAuthException) {
      return FailureApp(failureMessage: _handleFirebaseAuthError(error.code));
    }

    if (error is FirebaseException && error.plugin == 'cloud_firestore') {
      return FailureApp(failureMessage: _handleFirestoreError(error.code));
    }

    return FailureApp(failureMessage: 'common.errors.unexpected_error');
  }

  static String _handleFirebaseAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'auth.errors.invalid_email';

      case 'user-not-found':
        return 'auth.errors.user_not_found';

      case 'wrong-password':
      case 'invalid-credential':
        return 'auth.errors.invalid_credential';

      case 'email-already-in-use':
        return 'auth.errors.email_already_in_use';

      case 'weak-password':
        return 'auth.errors.weak_password';

      case 'email-not-verified':
        return 'auth.errors.email_not_verified';

      case 'requires-recent-login':
        return 'auth.errors.recent_login_required';

      case 'login-failed':
        return 'auth.errors.login_failed';

      case 'signup-failed':
        return 'auth.errors.signup_failed';

      case 'too-many-requests':
        return 'common.errors.too_many_requests';

      case 'network-request-failed':
        return 'common.errors.no_internet';

      case 'user-disabled':
      case 'operation-not-allowed':
        return 'auth.errors.login_failed';

      default:
        return 'common.errors.unexpected_error';
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'common.errors.connection_timeout';

      case DioExceptionType.sendTimeout:
        return 'common.errors.send_timeout';

      case DioExceptionType.receiveTimeout:
        return 'common.errors.receive_timeout';

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return 'common.errors.request_cancelled';

      case DioExceptionType.connectionError:
        return 'common.errors.no_internet';

      default:
        return 'common.errors.unexpected_error';
    }
  }

  static String _handleFirestoreError(String code) {
    switch (code) {
      case 'permission-denied':
        return 'common.errors.permission_denied';

      case 'unavailable':
        return 'common.errors.service_unavailable';

      case 'deadline-exceeded':
        return 'common.errors.request_timeout';

      case 'not-found':
        return 'common.errors.not_found';

      case 'already-exists':
        return 'common.errors.already_exists';

      case 'resource-exhausted':
        return 'common.errors.quota_exceeded';

      case 'unauthenticated':
        return 'auth.errors.user_not_logged_in';

      case 'cancelled':
        return 'common.errors.request_cancelled';

      default:
        return 'common.errors.database_error';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'common.errors.bad_request';

      case 401:
        return 'common.errors.unauthorized';

      case 403:
        return 'common.errors.permission_denied';

      case 404:
        return 'common.errors.not_found';

      case 408:
      case 504:
        return 'common.errors.request_timeout';

      case 429:
        return 'common.errors.too_many_requests';

      case 500:
      case 502:
      case 503:
        return 'common.errors.service_unavailable';

      default:
        return 'common.errors.unexpected_error';
    }
  }
}
