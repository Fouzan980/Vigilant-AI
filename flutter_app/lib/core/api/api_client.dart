import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/env_config.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    final baseUrl = EnvConfig.apiBaseUrl;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors for Auth tokens, logging, etc.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // e.g. inject JWT token
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle global errors here
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getReports({Map<String, dynamic>? queryParameters}) async {
    return _dio.get('/reports', queryParameters: queryParameters);
  }

  Future<Response> getReport(String id) async {
    return _dio.get('/reports/$id');
  }

  Future<Response> submitReport(Map<String, dynamic> data) async {
    return _dio.post('/reports', data: data);
  }

  Future<Response> updateReport(String id, Map<String, dynamic> data) async {
    return _dio.patch('/reports/$id', data: data);
  }

  Future<Response> deleteReport(String id) async {
    return _dio.delete('/reports/$id');
  }

  Future<Response> getUsers({Map<String, dynamic>? queryParameters}) async {
    return _dio.get('/users', queryParameters: queryParameters);
  }

  Future<Response> getAlerts({Map<String, dynamic>? queryParameters}) async {
    return _dio.get('/alerts', queryParameters: queryParameters);
  }
}
