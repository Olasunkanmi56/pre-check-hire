class LoginResponseDto {
  final String token;
  final Map<String, dynamic>? user;

  LoginResponseDto({
    required this.token,
    this.user,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      token: json['token'],
      user: json['user'],
    );
  }

  get data => null;
}
