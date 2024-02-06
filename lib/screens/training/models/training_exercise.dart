import 'dart:convert';

import 'package:gym_logger_2/constants/api.constants.dart';
import 'package:gym_logger_2/models/exercise-type.enum.dart';

List<TrainingExercise> trainingExercisesFromJson(String data) =>
    List<TrainingExercise>.from(
      json.decode(data).map(
            (e) => TrainingExercise.fromJson(e),
          ),
    );

String trainingExercisesToJson(List<TrainingExercise> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (e) => e.toJson(),
        ),
      ),
    );

class TrainingExercise {
  final int id;
  final int parentId;
  final String title;
  final String subTitle;
  final List<String> equipment;
  final String preparation;
  final List<dynamic> execution;
  final String? imagePath;
  final ExerciseType type;

  TrainingExercise({
    required this.id,
    required this.parentId,
    required this.title,
    required this.subTitle,
    required this.equipment,
    required this.preparation,
    required this.execution,
    required this.imagePath,
    required this.type,
  });

  factory TrainingExercise.fromJson(Map<String, dynamic> json) {
    String imgPath = '/public${json['imagePath'].split('/public')[1]}';

    return TrainingExercise(
      id: json['id'],
      parentId: json['parentId'],
      title: json['title'],
      subTitle: json['subTitle'],
      // equipment: List<String>.from(json['equipment'] ?? []),
      equipment: json['equipment'] != null
          ? (json['equipment'] as String).contains('|')
              ? (json['equipment'] as String).split('|')
              : [json['equipment']]
          : [],
      preparation: json['preparation'],
      execution: json['equipment'] != null
          ? (json['execution'] as String).contains('|')
              ? (json['execution'] as String).split('|')
              : [json['execution']]
          : [],
      imagePath: '$api${imgPath}',
      type: ExerciseType.values[json['type']],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'parentId': parentId,
        'subTitle': subTitle,
        'equipment': equipment,
        'preparation': preparation,
        'execution': execution,
        'imagePath': imagePath,
        'type': type,
      };
}
