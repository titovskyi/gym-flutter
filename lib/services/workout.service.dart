// import 'dart:convert';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:gym_logger_2/data/dummy_workouts.dart';
// import 'package:gym_logger_2/models/workout.dart';
// import 'package:gym_logger_2/screens/auth/auth.dart';

// // class WorkoutService {
// //   Future<List<Workout>> getAllWorkouts() async {
// //     try {
// //       return await Future.delayed(
// //         const Duration(seconds: 0),
// //         () {
// //           return workoutFromJson(dummyWorkouts);
// //         },
// //       );
// //     } catch (e) {
// //       print(e.toString());

// //       return [];
// //     }
// //   }

// //   Future<List<Workout>> getAllUserWorkouts(String uid) async {
// //     DatabaseReference databaseReference = rtdb.ref('workouts/$uid');

// //     final DataSnapshot snapshot = await databaseReference.get();

// //     return [];
// //   }

// //   Future<List<Workout>> getUserWorkoutsByDate(DateTime date, String uid) async {
// //     final formattedDate = '${date.day}-${date.month}-${date.year}';

// //     DatabaseReference databaseReference =
// //         rtdb.ref('workouts/$uid/$formattedDate');

// //     final DataSnapshot snapshot = await databaseReference.get();

// //     return snapshot.value != null
// //         ? workoutFromJson(snapshot.value as String)
// //         : [];
// //   }

// //   Future<void> postWorkouts(
// //       List<Workout> training, DateTime date, String uid) async {
// //     final formattedDate = '${date.day}-${date.month}-${date.year}';

// //     DatabaseReference databaseReference =
// //         rtdb.ref('workouts').child(uid).child(formattedDate);

// //     await databaseReference.set(json.encode(training));
// //   }
// // }
