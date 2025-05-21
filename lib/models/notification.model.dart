class UserNotification {
  final int id;
  final String message;
  final bool read;
  final DateTime createdAt;

  UserNotification({
    required this.id,
    required this.message,
    required this.read,
    required this.createdAt,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'],
      message: json['message'],
      read: json['read'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
