// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:gym_logger_2/models/workout.dart';

// class WorkoutTile extends ConsumerStatefulWidget {
//   final Workout workout;
//   final List<Workout> checkedWorkouts;
//   final Function onTileTap;

//   const WorkoutTile({
//     super.key,
//     required this.workout,
//     required this.checkedWorkouts,
//     required this.onTileTap,
//   });

//   @override
//   ConsumerState<WorkoutTile> createState() => _WorkoutTileState();
// }

// class _WorkoutTileState extends ConsumerState<WorkoutTile> {
//   bool? isChecked = false;

//   void _isInitChecked() {
//     isChecked = widget.checkedWorkouts
//         .where((el) => el.id == widget.workout.id)
//         .isNotEmpty;
//   }

//   @override
//   void initState() {
//     super.initState();

//     _isInitChecked();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: isChecked,
//           onChanged: (bool? value) {
//             widget.onTileTap(widget.workout);

//             setState(() {
//               isChecked = value;
//             });
//           },
//         ),
//         Text(widget.workout.title),
//       ],
//     );
//   }
// }
