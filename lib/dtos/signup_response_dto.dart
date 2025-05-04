import 'package:precheck_hire/dtos/ibase.dto.dart';

class SignupResponseDto {
  final String status;
  final String token;
  final String message;
  final UserData data;

  SignupResponseDto({
    required this.status,
    required this.token,
    required this.message,
    required this.data,
  });

  factory SignupResponseDto.fromJson(Map<String, dynamic> json) {
    return SignupResponseDto(
      status: json['status'],
      token: json['token'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String role;
  final bool active;
  final int accountId;
  final String status;
  final String kycVerified;
  final String identityTypeId;
  final String profileImageURL;
  final String registeredAt;
  final String updatedAt;
  final String createdAt;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.active,
    required this.accountId,
    required this.status,
    required this.kycVerified,
    required this.identityTypeId,
    required this.profileImageURL,
    required this.registeredAt,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      role: json['role'],
      active: json['active'],
      accountId: json['accountId'],
      status: json['status'],
      kycVerified: json['kycVerified'],
      identityTypeId: json['identityTypeId'],
      profileImageURL: json['profileImageURL'],
      registeredAt: json['registeredAt'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
}


