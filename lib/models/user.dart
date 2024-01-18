import 'package:gym_logger_2/models/profile.dart';

class User {
  final int id;
  final String email;
  final Profile profile;

  const User({
    required this.id,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'email': String email,
        'profile': Map<String, dynamic> profile,
      } =>
        User(
          id: id,
          email: email.toString(),
          profile: Profile.fromJson(profile),
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}
