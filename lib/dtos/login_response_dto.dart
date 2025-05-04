// dtos/login_response_dto.dart
class LoginResponseDto {
  final String token;
  final Map<String, dynamic>? user; // or create a UserDto if needed

  LoginResponseDto({
    required this.token,
    this.user,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      token: json['token'],
      user: json['user'], // optional
    );
  }
}
