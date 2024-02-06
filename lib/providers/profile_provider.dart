import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/models/profile.dart';
import 'package:gym_logger_2/models/role.enum.dart';

class ProfileNotifier extends StateNotifier<Profile> {
  ProfileNotifier()
      : super(
          const Profile(
            id: 0,
            email: '',
            role: Role.Sportsman,
          ),
        );

  void updateCurrentProfile(Profile profile) {
    state = profile;
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, Profile>(
  (ref) => ProfileNotifier(),
);
