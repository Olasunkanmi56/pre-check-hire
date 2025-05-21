class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String role;
  final String? kycVerificationStatus;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
    this.kycVerificationStatus,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      role: json['role'],
      kycVerificationStatus: json['kycVerificationStatus'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  bool get kycSubmitted => kycVerificationStatus == 'approved';
}
