import 'dart:convert';
import 'dart:io';

import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/screens/training/models/training.dart';
import 'package:gym_logger_2/services/storage.service.dart';
import 'package:gym_logger_2/constants/api.constants.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TrainingService {
  final SecureStorage secureStorage = SecureStorage();

  Future<void> save(
    DateTime? trainingDate,
    List<Exercise> exercises,
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');

    final response = await http.post(
      Uri.parse('$api/training'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
      body: jsonEncode({
        'createDate': trainingDate?.toIso8601String(),
        'exercises': exercises,
      }),
    );

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Training is not saved.'),
        ),
      );

      throw HttpException('${response.statusCode}');
    }

    return;
  }

  Future<List<Training>> getAllUserTrainings(
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');
    // final userId = decodeJwt(jwt);

    final response = await http.get(Uri.parse('$api/training'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt",
    });

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There is som error while getting trainings.'),
        ),
      );

      throw HttpException('${response.statusCode}');
    }

    return trainingsFromJson(response.body);
  }

  Future<bool> remove(BuildContext context, int trainingId) async {
    final jwt = await secureStorage.readSecureData('jwt');

    final response = await http.delete(
        Uri.parse(
          '$api/training/${trainingId.toString()}',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        });

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There is some error while removing training.'),
        ),
      );

      throw HttpException('${response.statusCode}');
    }

    return true;
  }
}
