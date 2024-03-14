import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/models/profile.dart';
import 'package:gym_logger_2/providers/calendar_provider.dart';
import 'package:gym_logger_2/providers/profile_provider.dart';
import 'package:gym_logger_2/screens/auth/auth.dart';
import 'package:gym_logger_2/screens/profile/profile.dart';
import 'package:gym_logger_2/screens/training/models/training.dart';
import 'package:gym_logger_2/services/training.service.dart';
import 'package:gym_logger_2/services/storage.service.dart';
import 'package:gym_logger_2/services/user.service.dart';

import 'package:gym_logger_2/widgets/calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  final uid = 'first';

  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  int _selectedIndex = 0;
  final SecureStorage secureStorage = SecureStorage();

  // late List<Exercise> workouts = [];
  late List<Training> trainings = [];
  late Profile? profile;

  @override
  void initState() {
    super.initState();

    _getUserProfile();
    _getUserTrainings();
  }

  void _getUserProfile() async {
    profile = await UserService().getProfile(context);

    if (profile != null) {
      ref.read(profileProvider.notifier).updateCurrentProfile(profile!);
    }
  }

  void _getUserTrainings() async {
    trainings = await TrainingService().getAllUserTrainings(context);

    setState(() {
      trainings = trainings;
    });
  }

  void _openNewExercise() async {
    bool? response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          // return const NewTrainingScreen();
          return const ProfileScreen();
        },
      ),
    );

    if (response != null) {
      trainings = await TrainingService().getAllUserTrainings(context);

      setState(() {
        trainings = trainings;
      });
    } else {
      print('without response');
    }
  }

  void _logout() {
    secureStorage.deleteSecureData('jwt');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
      ),
    );
  }

  void _profile() {
    Navigator.of(context).pushNamed('profile');
  }

  List<Widget> _contentWithEvents() {
    final currentDate = ref.watch(calendarProvider);
    final currentDateEvents = trainings.isNotEmpty
        ? trainings
            // .where(
            //   (element) =>
            //       // DateTime(
            //       //   currentDate.year,
            //       //   currentDate.month,
            //       //   currentDate.day,
            //       // ) ==
            //       // DateTime(
            //       //   element.createDate.year,
            //       //   element.createDate.month,
            //       //   element.createDate.day,
            //       // ),
            // )
            .toList()
        : [];

    return [
      CalendarWidget(
        uid: widget.uid,
        trainings: trainings,
      ),
      for (final training in currentDateEvents)
        Text(
          training.createDate.toString(),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        CalendarWidget(
          uid: widget.uid,
          trainings: trainings,
        ),
      ],
    );

    if (trainings.isNotEmpty) {
      content = Column(
        children: _contentWithEvents(),
      );
    }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          // TODO have to be moved to profile
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: _openNewExercise,
        child: const Icon(Icons.add),
      ),
    );
  }
}
