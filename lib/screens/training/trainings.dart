import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/providers/calendar_provider.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/screens/training/models/training.dart';
import 'package:gym_logger_2/screens/training/training.dart';
import 'package:gym_logger_2/services/training.service.dart';
import 'package:gym_logger_2/services/exercise.service.dart';
import 'package:gym_logger_2/widgets/exercise_tile.dart';

class TrainingsScreen extends ConsumerStatefulWidget {
  const TrainingsScreen({super.key});

  @override
  ConsumerState<TrainingsScreen> createState() {
    return _TrainingsScreenState();
  }
}

class _TrainingsScreenState extends ConsumerState<TrainingsScreen> {
  late List<Exercise> trainingExercises = [];

  late List<Exercise> _commonExercises = [];

  late List<Training> trainings = [];

  bool? isChecked = false;

  int count = 0;

  @override
  void initState() {
    super.initState();

    _getUserTrainings();
  }

  void _getUserTrainings() async {
    trainings = await TrainingService().getAllUserTrainings(context);

    setState(() {
      trainings = trainings;
    });
  }

  // TODO should be moved to ExercisesScreen and to TrainigScreen
  // void _getCommonExercises() async {
  //   _commonExercises = await ExerciseService().getCommonExersises(context);
  // }

  void showContent(List<Training> trainings) {}

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

  // // void _openAddWorkoutDialog() async {
  //   Widget content = Column(
  //     children: [
  //       for (final exercise in _commonExercises)
  //         ExerciseTile(
  //           exercise: exercise,
  //           checkedWorkouts: trainingExercises,
  //           onTileTap: _updateWorkoutToTraining,
  //           withCheckbox: true,
  //         ),
  //       ElevatedButton(
  //         onPressed: () {
  //           _getCommonExercises();
  //           Navigator.of(context).pop();
  //         },
  //         child: const Text('Add'),
  //       ),
  //     ],
  //   );

  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (ctx) => SizedBox(
  //       width: double.infinity,
  //       child: content,
  //     ),
  //     isScrollControlled: true,
  //     useSafeArea: true,
  //   );
  // }

  void _addNewTraining() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const TrainingScreen(),
      ),
    );

    _getUserTrainings();
  }

  void _removeTraining(int id) async {
    bool response = await TrainingService().remove(context, id);

    int trainingIndex = trainings.indexWhere((el) => el.id == id);
    trainings.remove(trainings[trainingIndex]);

    setState(() {
      trainings = trainings;
    });
  }

  Widget _createContent() {
    if (trainings.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: ListView.builder(
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(trainings[index].title!),
                  IconButton(
                    onPressed: () {
                      _removeTraining(trainings[index].id);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Text('Loading...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainings'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: _addNewTraining,
        child: const Icon(Icons.add),
      ),
      body: _createContent(),
    );
  }
}
