import 'package:dio/dio.dart';
import 'package:precheck_hire/dtos/login.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: 'https://api-stack-api.onrender.com/api/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      if (token != null) {
        _dio!.options.headers["Authorization"] = "Bearer $token";
      }
    }
    return _dio!;
  }
}


class AuthService {
  Future<void> login(LoginDto loginDto) async {
    final Dio _dio = await DioClient.getInstance();

    try {
      final response = await _dio.post(
        '/users/login', // baseUrl already included in DioClient
        data: loginDto.toJson(),
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token); 
      } else {
        throw Exception('Failed to login');
      }
    } on DioError catch (e) {
      throw Exception('Login error: ${e.response?.data['message'] ?? e.message}');
    }
  }
}
