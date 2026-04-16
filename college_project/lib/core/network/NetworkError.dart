import 'dart:io';
import 'package:dio/dio.dart';

class NetworkErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Server not responding.';
        case DioExceptionType.badResponse:
          final data = error.response?.data;
          final statusCode = error.response?.statusCode;

          if (statusCode == 422 && data is Map) {
            if (data['errors'] != null) {
              var firstError = (data['errors'] as Map).values.first;
              if (firstError is List) return firstError.first.toString();
              return firstError.toString();
            }
          }

          if (data is Map && data['message'] != null) {
            return data['message'].toString();
          }
          return 'Server error ($statusCode)';

        case DioExceptionType.connectionError:
          return 'No internet connection.';
        case DioExceptionType.cancel:
          return 'Request cancelled.';
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return 'Please check your internet connection.';
          }
          return 'An unknown error occurred.';
        default:
          return 'Network error occurred.';
      }
    }
    return 'Something went wrong. Please try again.';
  }
}
