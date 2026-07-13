import 'package:dio/dio.dart';
import '../error/exceptions.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  Future<Response> get(String path, {Map<String, dynamic>? query, Options? options}) =>
      _safe(() => dio.get(path, queryParameters: query, options: options));

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? query}) =>
      _safe(() => dio.post(path, data: data, queryParameters: query));

  Future<Response> put(String path, {dynamic data}) =>
      _safe(() => dio.put(path, data: data));

  Future<Response> delete(String path, {dynamic data}) =>
      _safe(() => dio.delete(path, data: data));

  Future<Response> uploadFile(String path, FormData formData, {ProgressCallback? onSendProgress}) =>
      _safe(() => dio.post(path, data: formData, onSendProgress: onSendProgress));

  Future<Response> _safe(Future<Response> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ServerException(message: 'Connection timeout, try again');
    }
    if (e.type == DioExceptionType.connectionError) {
      return ServerException(message: 'No internet connection');
    }
    final statusCode = e.response?.statusCode;
    final message = (e.response?.data is Map && e.response?.data['message'] != null)
        ? e.response!.data['message'].toString()
        : 'Something went wrong';
    if (statusCode == 401) return UnauthorizedException(message: message);
    return ServerException(message: message, statusCode: statusCode);
  }
}