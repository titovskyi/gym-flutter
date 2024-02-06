import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/models/profile.dart';
import 'package:gym_logger_2/providers/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late Profile profile;

  @override
  void initState() {
    super.initState();

    profile = ref.read(profileProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // TODO have to be moved to profile
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(children: [
        Text(profile.id.toString()),
        Text(profile.email),
        Text(profile.role.name),
      ]),
    );
  }
}
