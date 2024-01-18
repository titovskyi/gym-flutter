import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/providers/calendar_provider.dart';
import 'package:gym_logger_2/screens/auth/auth.dart';
// import 'package:gym_logger_2/screens/new_exercises.dart';
import 'package:gym_logger_2/models/workout.dart';
import 'package:gym_logger_2/services/storage.service.dart';
import 'package:gym_logger_2/services/user.service.dart';
// import 'package:gym_logger_2/services/workout.service.dart';

import 'package:gym_logger_2/widgets/calendar.dart';

class Calendar extends ConsumerStatefulWidget {
  final uid = 'first';

  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  final SecureStorage secureStorage = SecureStorage();

  late List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  void _getUserProfile() async {
    final profile = await UserService().getProfile(context);

    if (profile != null) {
      print(profile.id);
    }
  }

  void _getUserWorkouts() async {
    // final userWorkouts = await WorkoutService()
    //     .getUserWorkoutsByDate(ref.read(calendarProvider), widget.uid);

    // setState(() {
    //   workouts = userWorkouts;
    // });
  }

  void _openNewExercise() async {
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) {
    //       final choosenDate = ref.watch(calendarProvider);

    //       return NewExercises(choosenDate: choosenDate, uid: widget.uid);
    //     },
    //   ),
    // );

    // _getUserWorkouts();
  }

  void _logout() {
    secureStorage.deleteSecureData('jwt');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
      ),
    );
  }

  List<Widget> _contentWithEvents() {
    final currentDate = ref.watch(calendarProvider);
    final currentDateEvents = workouts.isNotEmpty
        ? workouts
            .where((el) => el.date!.difference(currentDate).inDays == 0)
            .toList()
        : [];

    return [
      CalendarWidget(uid: widget.uid),
      for (final workout in currentDateEvents) Text(workout.title),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        CalendarWidget(uid: widget.uid),
      ],
    );

    if (workouts.isNotEmpty) {
      content = Column(
        children: _contentWithEvents(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
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
