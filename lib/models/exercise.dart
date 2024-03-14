import 'dart:convert';

import 'package:gym_logger_2/constants/api.constants.dart';
import 'package:gym_logger_2/models/exercise-type.enum.dart';

List<Exercise> exercisesFromJson(String data) => List<Exercise>.from(
      json.decode(data).map(
            (e) => Exercise.fromJson(e),
          ),
    );

String exerciseToJson(List<Exercise> data) => json.encode(
      List<dynamic>.from(
        data.map((e) => e.toJson()),
      ),
    );

class Exercise {
  final int id;
  final String title;
  final String subTitle;
  final List<String> equipment;
  final String preparation;
  final List<String> execution;
  final String? imagePath;
  final ExerciseType type;

  Exercise({
    this.id = 0,
    required this.title,
    required this.subTitle,
    required this.equipment,
    required this.preparation,
    required this.execution,
    this.imagePath = '',
    required this.type,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    String imgPath = json['imagePath'] != ''
        ? '/public${json['imagePath'].split('/public')[1]}'
        : '';

    return Exercise(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
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
      imagePath: json['imagePath'] != '' ? '$api${imgPath}' : '',
      type: json['type'] != null
          ? ExerciseType.values[json['type']]
          : ExerciseType.Weight,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subTitle': subTitle,
        'equipment': equipment,
        'preparation': preparation,
        'execution': execution,
        'imagePath': imagePath,
        'type': 0
      };
}
