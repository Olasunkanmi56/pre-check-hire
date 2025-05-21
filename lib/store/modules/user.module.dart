import 'package:flutter/material.dart';
import 'package:precheck_hire/dtos/login.dto.dart';
import 'package:precheck_hire/dtos/signup_request_dto.dart';
import 'package:precheck_hire/models/user.model.dart';
import 'package:precheck_hire/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  User? user;

  Future<void> signup(SignupRequestDto dto) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _authService.signup(dto);
      user = User(
        id: response.data.id,
        firstName: response.data.firstName,
        lastName: response.data.lastName,
        email: response.data.email,
        phoneNumber: response.data.phoneNumber,
        address: response.data.address,
        role: response.data.role,
        profileImageUrl: null,
        kycVerificationStatus: '',
      );
    } catch (e) {
      print('Signup failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(LoginDto dto) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _authService.login(dto);

      final token = response.token; // adjust as per actual response model
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);

      // Parse user data properly
      final userMap =
          response
              .data; // Assuming your AuthService returns the parsed 'data' field here
      if (userMap != null) {
        user = User(
          id: userMap['id'],
          firstName: userMap['firstName'],
          lastName: userMap['lastName'],
          email: userMap['email'],
          phoneNumber: userMap['phoneNumber'],
          address: userMap['address'],
          role: userMap['role'],
          kycVerificationStatus: userMap['kycVerificationStatus'],
          profileImageUrl: userMap['profileImageUrl'],
        );
      }
    } catch (e) {
      print('Login failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('remember_me');

    user = null;
    notifyListeners();
  }

  Future<void> sendVerificationEmail(String email) async {
    await AuthService().sendVerificationEmail(email);
  }
}
