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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_logger_2/constants/api.constants.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/services/storage.service.dart';
import 'package:http/http.dart' as http;

class ExerciseService {
  final SecureStorage secureStorage = SecureStorage();

  Future<List<Exercise>> getCommonExersises(
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');

    var response = await http.get(Uri.parse('$api/exercise'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt",
    });

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is not exist.'),
        ),
      );

      throw HttpException('${response.statusCode}');
    }

    return exercisesFromJson(response.body);
  }

  Future<void> create(
    Exercise exercise,
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');

    final response = await http.post(
      Uri.parse('$api/exercise'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
      body: jsonEncode(exercise),
    );

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exercise is not saved.'),
        ),
      );

      throw HttpException('${response.statusCode}');
    }

    return;
  }
}

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