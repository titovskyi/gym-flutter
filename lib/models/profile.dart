import 'package:gym_logger_2/models/role.enum.dart';

class Profile {
  final int id;
  final String email;
  final Role role;

  const Profile({
    required this.id,
    required this.email,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'email': String email,
        'role': int role,
      } =>
        Profile(
          id: id,
          email: email,
          role: Role.values[role],
        ),
      _ => throw const FormatException('Failed to load profile.'),
    };
  }
}
