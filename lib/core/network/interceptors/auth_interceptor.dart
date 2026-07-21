// core/network/interceptors/auth_interceptor.dart
import 'dart:async';
import 'package:dio/dio.dart';
import '../../storage/secure_storage_service.dart';
import '../api_endpoints.dart';
import '../../../app/event_bus.dart';

class _QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;
  _QueuedRequest(this.options, this.completer);
}

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageService storage;
  bool _isRefreshing = false;
  final List<_QueuedRequest> _queue = [];

  AuthInterceptor(this.dio, this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final path = options.path;
    final isAuthPath = path.contains(ApiEndpoints.sendOtp) || 
                       path.contains(ApiEndpoints.verifyOtp) ||
                       path.contains(ApiEndpoints.login);

    if (!isAuthPath) {
      final token = await storage.getAccessToken();
      if (token != null) options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Agar 401 nahi hai toh aage badhein
    if (err.response?.statusCode != 401) return handler.next(err);

    final path = err.requestOptions.path;
    final isAuthPath = path.contains(ApiEndpoints.sendOtp) || 
                       path.contains(ApiEndpoints.verifyOtp) ||
                       path.contains(ApiEndpoints.login);

    // Agar Login ya OTP verify ke waqt 401 aaya hai, toh ye session expire nahi hai
    // Ye sirf "Wrong OTP" ya "Invalid Credentials" hai.
    if (isAuthPath) return handler.next(err);

    final requestOptions = err.requestOptions;

    if (_isRefreshing) {
      final completer = Completer<Response>();
      _queue.add(_QueuedRequest(requestOptions, completer));
      try {
        return handler.resolve(await completer.future);
      } catch (_) {
        return handler.next(err);
      }
    }

    _isRefreshing = true;
    try {
      final refreshToken = await storage.getRefreshToken();
      // Khali string ('') ko bhi handle karein
      if (refreshToken == null || refreshToken.isEmpty) {
        throw Exception('No refresh token available');
      }

      final response = await Dio().post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
        data: {'refreshToken': refreshToken},
      );

      final newAccess = response.data['accessToken'];
      final newRefresh = response.data['refreshToken'];
      await storage.saveTokens(accessToken: newAccess, refreshToken: newRefresh);

      requestOptions.headers['Authorization'] = 'Bearer $newAccess';
      final retried = await dio.fetch(requestOptions);

      for (final q in _queue) {
        q.options.headers['Authorization'] = 'Bearer $newAccess';
        dio.fetch(q.options).then(q.completer.complete).catchError(q.completer.completeError);
      }
      _queue.clear();
      _isRefreshing = false;
      return handler.resolve(retried);
    } catch (e) {
      _isRefreshing = false;
      for (final q in _queue) {
        q.completer.completeError(e);
      }
      _queue.clear();
      await storage.clearTokens();
      AppEventBus.instance.fireSessionExpired();
      return handler.next(err);
    }
  }
}

