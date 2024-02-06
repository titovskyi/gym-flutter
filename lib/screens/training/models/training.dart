import 'dart:convert';

import 'package:gym_logger_2/screens/training/models/training_exercise.dart';

List<Training> trainingsFromJson(String data) => List<Training>.from(
      json.decode(data).map(
            (e) => Training.fromJson(e),
          ),
    );

String trainingsToJson(List<Training> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (e) => e.toJson(),
        ),
      ),
    );

class Training {
  final int id;
  final DateTime createDate;
  final List<TrainingExercise> exercises;

  Training({
    required this.id,
    required this.createDate,
    required this.exercises,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      createDate: DateTime.parse(json['createDate']),
      exercises: (json['exercises'] as List)
          .map(
            (e) => TrainingExercise.fromJson(e),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createDate': createDate,
        'exercises': exercises,
      };
}
