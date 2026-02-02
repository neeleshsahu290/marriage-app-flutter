// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'api_interceptor.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(ApiInterceptor(_dio));
  }

  // -------------------- GET --------------------
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // -------------------- POST --------------------
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // -------------------- PUT --------------------
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // -------------------- PATCH --------------------
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // -------------------- DELETE --------------------
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // -------------------- MULTIPART (UPLOAD) --------------------
  Future<Response<T>> upload<T>(
    String path, {
    required FormData data,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      options: options ?? Options(contentType: 'multipart/form-data'),
      onSendProgress: onSendProgress,
    );
  }

  // -------------------- DOWNLOAD --------------------
  Future<Response> download(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Options? options,
  }) async {
    return await _dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );
  }
}
