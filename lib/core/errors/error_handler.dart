import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../failure/failure_app.dart';

class ErrorHandler {
  static FailureApp getErrorMessage(Object error) {
    // Dio Errors
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return FailureApp(failureMessage: 'Connection timeout');

        case DioExceptionType.sendTimeout:
          return FailureApp(failureMessage: 'Send timeout');

        case DioExceptionType.receiveTimeout:
          return FailureApp(failureMessage: 'Receive timeout');

        case DioExceptionType.badResponse:
          return FailureApp(
            failureMessage: _handleStatusCode(error.response?.statusCode),
          );

        case DioExceptionType.cancel:
          return FailureApp(failureMessage: 'Request cancelled');

        case DioExceptionType.connectionError:
          return FailureApp(failureMessage: 'No internet connection');

        default:
          return FailureApp(failureMessage: 'Something went wrong');
      }
    }

    // Firebase Authentication Errors
    if (error is FirebaseAuthException) {
      return FailureApp(failureMessage: _handleFirebaseAuthError(error.code));
    }

    // Cloud Firestore Errors
    if (error is FirebaseException && error.plugin == 'cloud_firestore') {
      return FailureApp(failureMessage: _handleFirestoreError(error.code));
    }

    return FailureApp(failureMessage: 'Unexpected error');
  }

  // Firebase Authentication
  static String _handleFirebaseAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid email address';

      case 'user-not-found':
        return 'No user found with this email';

      case 'wrong-password':
        return 'Incorrect password';

      case 'invalid-credential':
        return 'Invalid email or password';

      case 'email-already-in-use':
        return 'Email is already registered';

      case 'weak-password':
        return 'Password is too weak';

      case 'user-disabled':
        return 'This user account has been disabled';

      case 'operation-not-allowed':
        return 'This operation is not allowed';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later';

      case 'network-request-failed':
        return 'No internet connection';

      case 'requires-recent-login':
        return 'Please sign in again to continue';

      default:
        return 'Authentication failed';
    }
  }

  // Cloud Firestore
  static String _handleFirestoreError(String code) {
    switch (code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action';

      case 'unavailable':
        return 'Service is temporarily unavailable';

      case 'deadline-exceeded':
        return 'The operation timed out';

      case 'not-found':
        return 'Requested document was not found';

      case 'already-exists':
        return 'Document already exists';

      case 'resource-exhausted':
        return 'Service quota exceeded';

      case 'unauthenticated':
        return 'Please sign in first';

      case 'cancelled':
        return 'Operation cancelled';

      default:
        return 'Database operation failed';
    }
  }

  // HTTP Status Codes
  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Not found';

      case 408:
        return 'Request timeout';

      case 429:
        return 'Too many requests';

      case 500:
        return 'Internal server error';

      case 502:
        return 'Bad gateway';

      case 503:
        return 'Service unavailable';

      case 504:
        return 'Gateway timeout';

      default:
        return 'Something went wrong';
    }
  }
}
