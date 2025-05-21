import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static Dio? _dio;

  // Initializes and returns Dio instance
  static Future<Dio> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    // Create Dio only once
    _dio ??= Dio(BaseOptions(
      baseUrl: 'https://api-stack-api.onrender.com/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Always refresh the Authorization header
    if (token != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio!.options.headers.remove('Authorization');
    }

    // print('[DIO CLIENT] Auth Header: ${_dio!.options.headers['Authorization']}');

    return _dio!;
  }

  // Call this after login to update headers
  static Future<void> refreshTokenHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (_dio != null) {
      if (token != null) {
        _dio!.options.headers['Authorization'] = 'Bearer $token';
      } else {
        _dio!.options.headers.remove('Authorization');
      }

      print('[DIO CLIENT] Refreshed Auth Header: ${_dio!.options.headers['Authorization']}');
    }
  }
}
