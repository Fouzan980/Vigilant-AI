import 'package:dio/dio.dart';
import '../../config/env_config.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? client})
    : dio =
          client ??
          Dio(
            BaseOptions(
              baseUrl: EnvConfig.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      dio.get(path, queryParameters: queryParameters);
  Future<Response> post(String path, {dynamic data}) =>
      dio.post(path, data: data);
  Future<Response> patch(String path, {dynamic data}) =>
      dio.patch(path, data: data);
  Future<Response> delete(String path) => dio.delete(path);
  Future<Response> getReports({Map<String, dynamic>? queryParameters}) =>
      get('/reports', queryParameters: queryParameters);
  Future<Response> submitReport(Map<String, dynamic> data) =>
      post('/reports', data: data);
  Future<Response> getUsers({Map<String, dynamic>? queryParameters}) =>
      get('/users', queryParameters: queryParameters);
  Future<Response> getAlerts({Map<String, dynamic>? queryParameters}) =>
      get('/alerts', queryParameters: queryParameters);
}
