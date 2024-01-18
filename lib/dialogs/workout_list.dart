// import 'package:flutter/material.dart';
// import 'package:gym_logger_2/constants/translation.constants.dart';

// import 'package:gym_logger_2/models/workout.dart';
// import 'package:gym_logger_2/services/workout.service.dart';
// import 'package:gym_logger_2/widgets/workout_tile.dart';

// class WorkoutListDialog extends StatefulWidget {
//   const WorkoutListDialog({super.key});

//   @override
//   State<WorkoutListDialog> createState() => _WorkoutListDialogState();
// }

// class _WorkoutListDialogState extends State<WorkoutListDialog> {
//   List<Workout> _allWorkouts = [];

//   @override
//   void initState() {
//     super.initState();

//     _getAllWorkouts();
//   }

//   void _getAllWorkouts() async {
//     _allWorkouts = await WorkoutService().getAllWorkouts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content = const Text(NO_WORKOUTS);

//     if (_allWorkouts.isNotEmpty) {
//       Column(
//         children: [
//           for (final workout in _allWorkouts)
//             WorkoutTile(
//               workout: workout,
//               isChecked: false,
//             ),
//         ],
//       );
//     }

//     return content;
//   }
// }
