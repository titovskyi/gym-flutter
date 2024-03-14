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
  final String? title;
  final DateTime? createDate;
  final List<TrainingExercise> exercises;

  Training({
    required this.id,
    required this.title,
    required this.createDate,
    required this.exercises,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    // final fakeTitle =
    // '${DateTime.parse(json['createDate']).day}-${DateTime.parse(json['createDate']).month}-${DateTime.parse(json['createDate']).year}';

    return Training(
      id: json['id'],
      title: json['title'] ?? 'Training',
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
      exercises: (json['exercises'] as List)
          .map(
            (e) => TrainingExercise.fromJson(e),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'createDate': createDate,
        'exercises': exercises,
      };
}
