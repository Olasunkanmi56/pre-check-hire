import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:precheck_hire/dtos/login.dto.dart';
import 'package:precheck_hire/dtos/login_response_dto.dart';
import '../dtos/signup_request_dto.dart';
import '../dtos/signup_response_dto.dart';
import 'dto_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<SignupResponseDto> signup(SignupRequestDto signupRequestDto) async {
    final dio = await DioClient.getInstance();
    final response = await dio.post(
      '/users/signup',
      data: signupRequestDto.toJson(),
    );

    final signupResponse = SignupResponseDto.fromJson(response.data);

    // Save token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', signupResponse.token);

    return signupResponse;
  }

  Future<LoginResponseDto> login(LoginDto loginDto) async {
    final Dio dio = await DioClient.getInstance();

    try {
      final response = await dio.post('/users/login', data: loginDto.toJson());

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseDto.fromJson(response.data);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', response.data['token']);
        await DioClient.refreshTokenHeader();

        // Optionally handle rememberMe if needed
        if (loginDto.rememberMe == true) {
          await prefs.setBool('remember_me', true);
        }

        return loginResponse;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? 'Unexpected error';
      throw Exception('Login error: $errorMsg');
    }
  }

  Future<void> logout() async {
    final dio = await DioClient.getInstance();

    try {
      final response = await dio.get('/users/logout');

      if (response.statusCode == 200) {
        // Clear tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('access_token');
        await prefs.remove('refresh_token'); // If stored
      } else {
        throw Exception('Failed to log out');
      }
    } catch (e) {
      print('Logout failed: $e');
      rethrow;
    }
  }

  Future<void> sendVerificationEmail(String email) async {
    final Dio dio = await DioClient.getInstance();
    await dio.post(
      'https://api-stack-api.onrender.com/api/v1/users/sendEmailVerification',
      data: {'email': email},
    );
  }

  Future<void> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    final Dio dio = await DioClient.getInstance();

    try {
      final response = await dio.post(
        '/users/emailTokenVerification',
        data: {'email': email, 'token': token},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract and store the token
        final jwt = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', jwt);
      } else {
        throw Exception('Invalid or expired token');
      }
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['message'] != null) {
        throw Exception(e.response!.data['message']);
      }
      throw Exception('Verification failed: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final Dio dio = await DioClient.getInstance();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('No token found. Please log in again.');
    }

    try {
      final response = await dio.get(
        '/users/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data'];
      } else {
        throw Exception(
          'Failed to fetch profile. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Handle expired token (401 Unauthorized)
      if (e.response?.statusCode == 401) {
        await prefs.remove('access_token'); // clear expired token
        throw Exception('Session expired. Please log in again.');
      }

      // Handle backend errors with message
      if (e.response?.data is Map && e.response?.data['message'] != null) {
        throw Exception(e.response!.data['message']);
      }

      // Fallback error
      throw Exception('Profile fetch failed: ${e.message}');
    }
  }

  Future<void> updateUserProfile({
  required String firstName,
  required String lastName,
  required String phoneNumber,
  required String address,
  File? profileImageUrl,
}) async {
  final dio = await DioClient.getInstance();

  final formData = FormData.fromMap({
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'address': address,
    if (profileImageUrl != null)
      'profileImageUrl': await MultipartFile.fromFile(profileImageUrl.path),
  });

  try {
    final response = await dio.patch(
      '/users/updateMe',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        validateStatus: (status) => true, // Let us catch 500 manually
      ),
    );

    if (response.statusCode == 500) {
      throw Exception("Internal server error: ${response.data}");
    } else if (response.statusCode != 200) {
      throw Exception("Failed with status ${response.statusCode}: ${response.data}");
    }
  } catch (e) {
    throw Exception("Error updating profile: $e");
  }
}

  

  Future<void> forgotPassword(String email) async {
    final Dio dio = await DioClient.getInstance();

    try {
      final response = await dio.post(
        '/users/forgotPassword',
        data: {'email': email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to send reset token');
      }
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['message'] != null) {
        throw Exception(e.response!.data['message']);
      }
      throw Exception('Reset request failed: ${e.message}');
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    final Dio dio = await DioClient.getInstance();

    try {
      final response = await dio.patch(
        '/users/resetPassword',
        data: {
          "email": email,
          "token": token,
          "password": password,
          "passwordConfirm": confirmPassword,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        // Success: Password reset successful
      } else {
        throw Exception("Reset failed. Try again.");
      }
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['message'] != null) {
        throw Exception(e.response!.data['message']);
      }
      throw Exception("Reset failed: ${e.message}");
    }
  }

  Future<void> submitKYC({
    required int identityTypeId,
    required String identityNumber,
    required DateTime identityIssueDate,
    required DateTime identityExpiryDate,
    required String identityImageFrontPath,
    required String identityImageBackPath,
  }) async {
    final Dio dio = await DioClient.getInstance();

    try {
      final formData = FormData.fromMap({
        'identityTypeId': identityTypeId.toString(),
        'identityNumber': identityNumber,
        'identityIssueDate': DateFormat('yyyy-MM-dd').format(identityIssueDate),
        'identityExpiryDate': DateFormat(
          'yyyy-MM-dd',
        ).format(identityExpiryDate),
        'identityImageFront': await MultipartFile.fromFile(
          identityImageFrontPath,
        ),
        'identityImageBack': await MultipartFile.fromFile(
          identityImageBackPath,
        ),
      });

      final response = await dio.patch('/users/userKYCUpdate', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
       
      } else {
        throw Exception('Failed to submit KYC: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? 'Unknown error';
      throw Exception('KYC submission failed: $errorMsg');
    }
  }

  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final Dio dio = await DioClient.getInstance();
    try {
      final response = await dio.patch(
        '/users/updateMyPassword',
        data: {'passwordCurrent': currentPassword, 'password': newPassword},
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
