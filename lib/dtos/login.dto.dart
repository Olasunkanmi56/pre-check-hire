import 'package:precheck_hire/dtos/ibase.dto.dart';

class LoginDto {
  final String email;
  final String password;
  final bool? rememberMe;

  LoginDto({
    required this.email,
    required this.password,
    this.rememberMe,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

