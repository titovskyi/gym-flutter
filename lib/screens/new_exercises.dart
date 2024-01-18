// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gym_logger_2/constants/translation.constants.dart';
// import 'package:gym_logger_2/providers/calendar_provider.dart';
// import 'package:gym_logger_2/models/workout.dart';
// import 'package:gym_logger_2/providers/workouts_provider.dart';
// import 'package:gym_logger_2/services/workout.service.dart';
// import 'package:gym_logger_2/widgets/workout_tile.dart';

// class NewExercises extends ConsumerStatefulWidget {
//   final DateTime choosenDate;
//   final String uid;

//   const NewExercises({super.key, required this.choosenDate, required this.uid});

//   @override
//   ConsumerState<NewExercises> createState() {
//     return NewExercisesState();
//   }
// }

// class NewExercisesState extends ConsumerState<NewExercises> {
//   late List<Workout> _allWorkouts = [];
//   late List<Workout> _userWorkouts = [];
//   late List<Workout> trainingWorkouts = [];

//   bool? isChecked = false;

//   int count = 0;

//   List<Workout> get _userWorkoutsByDate => _userWorkouts
//       .where(
//           (el) => el.date!.difference(ref.read(calendarProvider)).inDays == 0)
//       .toList();

//   @override
//   void initState() {
//     super.initState();

//     _getAllWorkouts();
//     _getUserWorkouts();
//   }

//   void _getAllWorkouts() async {
//     _allWorkouts = await WorkoutService().getAllWorkouts();
//   }

//   void _getUserWorkouts() async {
//     final workouts = await WorkoutService()
//         .getUserWorkoutsByDate(ref.read(calendarProvider), widget.uid);

//     setState(() {
//       _userWorkouts = workouts;
//     });
//   }

//   void _updateWorkoutToTraining(Workout item) {
//     final workoutExist = trainingWorkouts.where((el) => item.id == el.id);

//     if (workoutExist.isEmpty) {
//       trainingWorkouts.add(item);
//     } else {
//       trainingWorkouts.removeWhere((el) => el.id == item.id);
//     }

//     setState(() {
//       trainingWorkouts = trainingWorkouts;
//     });
//   }

//   void _saveWorkouts() async {
//     await WorkoutService()
//         .postWorkouts(trainingWorkouts, ref.read(calendarProvider), widget.uid);
//   }

//   void _openAddWorkoutDialog() async {
//     Widget content = const Text(NO_WORKOUTS);

//     if (_allWorkouts.isNotEmpty) {
//       content = Column(
//         children: [
//           for (final workout in _allWorkouts)
//             WorkoutTile(
//               workout: workout,
//               checkedWorkouts: trainingWorkouts,
//               onTileTap: _updateWorkoutToTraining,
//             ),
//           ElevatedButton(
//             onPressed: () {
//               _getUserWorkouts();
//               Navigator.of(context).pop();
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       );
//     }

//     await showModalBottomSheet(
//       context: context,
//       builder: (ctx) => SizedBox(
//         width: double.infinity,
//         child: content,
//       ),
//       isScrollControlled: true,
//       useSafeArea: true,
//     );
//   }

//   void _addNewTraining() async {
//     _saveWorkouts();

//     _popScreen();
//   }

//   void _popScreen() {
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add workouts'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         shape: const CircleBorder(),
//         onPressed: _addNewTraining,
//         child: const Icon(Icons.add),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 10,
//         ),
//         child: Column(
//           children: [
//             OutlinedButton(
//               onPressed: _openAddWorkoutDialog,
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add),
//                   Text('Add workout'),
//                 ],
//               ),
//             ),
//             for (final workout in trainingWorkouts) Text(workout.title),
//           ],
//         ),
//       ),
//     );
//   }
// }
