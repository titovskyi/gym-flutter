import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/screens/exercises/exercises.dart';
import 'package:gym_logger_2/widgets/exercise_tile.dart';
import 'package:gym_logger_2/services/training.service.dart';

class TrainingScreen extends StatefulWidget {
  final int? trainingId;

  const TrainingScreen({
    super.key,
    this.trainingId,
  });

  @override
  State<TrainingScreen> createState() {
    return _TrainingScreenState();
  }
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'Your title');

  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();

    if (widget.trainingId != null) {
      _getTrainingExercises();
    }
  }

  void _getTrainingExercises() {}

  void _showExercises() async {
    List<Exercise>? response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ExercisesScreen(
          exercises: [...exercises],
          withCheckbox: true,
        ),
      ),
    );

    setState(() {
      if (response != null && response.isNotEmpty) {
        exercises = response;
      }
    });
  }

  void _createTraining() async {
    await TrainingService().save(null, exercises, context);

    _goBack();
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: _createActions(),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: const Color.fromARGB(255, 80, 83, 80),
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        onPressed: _showExercises,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: _createContent(),
      ),
    );
  }

  Widget _createContent() {
    if (exercises.isEmpty) {
      return const Text(
        'There are no exercises!',
        style: TextStyle(
          color: Colors.white,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return ExerciseTile(
                exercise: exercises[index],
                checkedWorkouts: [],
                onTileTap: () {},
                withCheckbox: false,
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _createActions() {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: _createTraining,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    ];
  }
}
