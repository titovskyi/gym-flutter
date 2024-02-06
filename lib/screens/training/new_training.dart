import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/data/dummy_workouts.dart';
// import 'package:gym_logger_2/constants/translation.constants.dart';
import 'package:gym_logger_2/providers/calendar_provider.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/screens/training/training.service.dart';
import 'package:gym_logger_2/services/exercise.service.dart';
import 'package:gym_logger_2/widgets/exercise_tile.dart';
// import 'package:gym_logger_2/providers/workouts_provider.dart';
// import 'package:gym_logger_2/services/workout.service.dart';
// import 'package:gym_logger_2/widgets/workout_tile.dart';

class NewTrainingScreen extends ConsumerStatefulWidget {
  // final DateTime choosenDate;
  // final String uid;

  const NewTrainingScreen({super.key});

  @override
  ConsumerState<NewTrainingScreen> createState() {
    return NewTrainingScreenState();
  }
}

class NewTrainingScreenState extends ConsumerState<NewTrainingScreen> {
  late List<Exercise> trainingExercises = [];

  late List<Exercise> _commonExercises = [];

  bool? isChecked = false;

  int count = 0;

  @override
  void initState() {
    super.initState();

    _getCommonExercises();
  }

  void _getCommonExercises() async {
    _commonExercises = await ExerciseService().getCommonExersises(context);
  }

  void _updateWorkoutToTraining(Exercise item) {
    final workoutExist = trainingExercises.where((el) => item.id == el.id);

    if (workoutExist.isEmpty) {
      trainingExercises.add(item);
    } else {
      trainingExercises.removeWhere((el) => el.id == item.id);
    }

    setState(() {
      trainingExercises = trainingExercises;
    });
  }

  void _openAddWorkoutDialog() async {
    Widget content = Column(
      children: [
        for (final exercise in _commonExercises)
          ExerciseTile(
            exercise: exercise,
            checkedWorkouts: trainingExercises,
            onTileTap: _updateWorkoutToTraining,
            withCheckbox: true,
          ),
        ElevatedButton(
          onPressed: () {
            _getCommonExercises();
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );

    await showModalBottomSheet(
      context: context,
      builder: (ctx) => SizedBox(
        width: double.infinity,
        child: content,
      ),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }

  void _addNewTraining() async {
    final trainingDate = ref.read(calendarProvider);

    await TrainingService().save(trainingDate, trainingExercises, context);

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Training'),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: _addNewTraining,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            OutlinedButton(
              onPressed: _openAddWorkoutDialog,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Add workout'),
                ],
              ),
            ),
            for (final workout in trainingExercises)
              ExerciseTile(
                  exercise: workout,
                  checkedWorkouts: trainingExercises,
                  onTileTap: _updateWorkoutToTraining,
                  withCheckbox: false),
          ],
        ),
      ),
    );
  }
}
