
class SignupRequestDto {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String? address;
  final String role;
  final int subscriptionPlanId;

  SignupRequestDto({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
     this.address,
    required this.role,
    required this.subscriptionPlanId,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "address": address,
      "role": role,
      "subscriptionPlanId": subscriptionPlanId,
    };
  }
}
