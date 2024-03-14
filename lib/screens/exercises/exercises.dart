import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/screens/exercises/edit-exercise.dart';
import 'package:gym_logger_2/screens/exercises/exercise.dart';
import 'package:gym_logger_2/services/exercise.service.dart';
import 'package:gym_logger_2/widgets/exercise_tile.dart';
import 'package:gym_logger_2/widgets/layout/layout.dart';

class ExercisesScreen extends StatefulWidget {
  final List<Exercise> exercises;
  final bool withCheckbox;
  final bool withoutBackButton;

  const ExercisesScreen({
    super.key,
    required this.exercises,
    this.withCheckbox = false,
    this.withoutBackButton = false,
  });

  @override
  State<ExercisesScreen> createState() {
    return _ExercisesScreenState();
  }
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  // final ScrollController _scrollController = ScrollController();

  late List<Exercise> commonExercises = [];

  @override
  void initState() {
    super.initState();

    _getCommonExercises();
  }

  @override
  Widget build(BuildContext context) {
    return GymLayout(
      title: 'Exercises',
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _showContent(),
      ),
      leading: widget.withoutBackButton
          ? null
          : IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                widget.exercises.clear();

                Navigator.pop(context);
              },
            ),
      actions: _createActions(),
    );
    // return Scaffold(
    // backgroundColor: Color.fromARGB(255, 0, 0, 0),
    // appBar: AppBar(
    //   automaticallyImplyLeading: false,
    //   backgroundColor: Colors.black,
    //   title: const Text(
    //     'Exercises',
    //     style: TextStyle(
    //       color: Colors.white,
    //     ),
    //   ),
    // leading: widget.withoutBackButton
    //     ? null
    //     : IconButton(
    //         icon: const Icon(
    //           Icons.chevron_left,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {
    //           widget.exercises.clear();

    //           Navigator.pop(context);
    //         },
    //       ),
    // actions: _createActions(),
    // ),
    // body: Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: _showContent(),
    // ),
    // );
  }

  List<Widget> _createActions() {
    List<Widget> actions = [];

    if (widget.withCheckbox) {
      actions.add(
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context, widget.exercises);
            },
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      actions.add(
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: _addNewExercise,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return actions;
  }

  void _getCommonExercises() async {
    commonExercises = await ExerciseService().getCommonExersises(context);

    setState(() {
      commonExercises = commonExercises;
    });
  }

  Widget _showContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: commonExercises.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ExerciseTile(
                  exercise: commonExercises[index],
                  checkedWorkouts: widget.exercises,
                  onTileTap: _onExerciseTap,
                  withCheckbox: widget.withCheckbox,
                ),
              );
              // ),
            },
          ),
        )
      ],
    );
  }

  void _addNewExercise() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return EditExerciseScreen();
        },
      ),
    );

    _getCommonExercises();
  }

  void _onExerciseTap(Exercise exercise) {
    if (widget.withoutBackButton) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return ExerciseScreen(exercise: exercise);
          },
        ),
      );
    } else {
      int existExerciseIndex =
          widget.exercises.indexWhere((ex) => ex.id == exercise.id);

      existExerciseIndex != -1
          ? widget.exercises.remove(widget.exercises[existExerciseIndex])
          : widget.exercises.add(exercise);
    }
  }
}
