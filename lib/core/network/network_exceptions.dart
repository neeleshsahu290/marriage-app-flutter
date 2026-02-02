// core/network/network_exceptions.dart

import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  final String message;

  NetworkExceptions._(this.message);

  factory NetworkExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkExceptions._('Connection timeout');

      case DioExceptionType.sendTimeout:
        return NetworkExceptions._('Request timeout');

      case DioExceptionType.receiveTimeout:
        return NetworkExceptions._('Response timeout');

      case DioExceptionType.badResponse:
        return NetworkExceptions._(
          error.response?.data?['message'] ?? 'Server error',
        );

      case DioExceptionType.connectionError:
        return NetworkExceptions._('No internet connection');

      case DioExceptionType.cancel:
        return NetworkExceptions._('Request cancelled');

      default:
        return NetworkExceptions._('Unexpected error occurred');
    }
  }

  @override
  String toString() => message;
}
