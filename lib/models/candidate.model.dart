class Candidate {
  final int id;
  final String fullName;
  final String? profileImageUrl;
  final int? yearsOfExperience;
  final bool isBlacklisted;

  Candidate({
    required this.id,
    required this.fullName,
    required this.profileImageUrl,
    required this.yearsOfExperience,
    required this.isBlacklisted,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      yearsOfExperience: json['yearsOfExperience'], // nullable
      isBlacklisted: json['blacklistCount'] != null && json['blacklistCount'] > 0,
    );
  }
}
