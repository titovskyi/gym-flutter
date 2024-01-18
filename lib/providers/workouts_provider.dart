// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gym_logger_2/models/workout.dart';

// class WorkoutsNotifier extends StateNotifier<List<Workout>> {
//   WorkoutsNotifier() : super([]);

//   // final List<Workout> training = [];

//   // void addWorkouts(List<Workout> workouts) {
//   //   state = [...state, ...workouts];
//   // }

//   // void addWorkoutToTraining(
//   //   Workout workout,
//   //   DateTime date,
//   // ) {
//   //   state = [
//   //     ...state,
//   //     Workout(
//   //       id: workout.id,
//   //       title: workout.title,
//   //       date: date,
//   //     ),
//   //   ];
//   // }

//   // void removeWorkoutFromTraining(Workout workout) {}

//   void setupUserWorkouts(List<Workout> workouts) {
//     state = [...state, ...workouts];
//   }

//   void clearUserWorkouts() {
//     state = [];
//   }

//   void addWorkout(Workout workout) {
//     state = [...state, workout];
//   }

//   void removeWorkout(Workout workout) {
//     state.removeWhere((el) => el.id == workout.id);

//     state = [...state];
//   }
// }

// final workoutsProvider = StateNotifierProvider<WorkoutsNotifier, List<Workout>>(
//     (ref) => WorkoutsNotifier());
