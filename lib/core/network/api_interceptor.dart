// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'network_exceptions.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  //final SecureStorage _storage = SecureStorage();

  ApiInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = AppPrefs.getString(PrefNames.authToken);

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Debug log
    // ignore: avoid_print
    print('➡️ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('✅ ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final networkException = NetworkExceptions.fromDioError(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        message: networkException.message,
      ),
    );
  }
}
