import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/profile.dart';
import 'package:gym_logger_2/screens/auth/utils.dart';
import 'package:gym_logger_2/services/storage.service.dart';
import 'package:http/http.dart' as http;

import 'package:gym_logger_2/constants/api.constants.dart';
import 'package:gym_logger_2/models/user.dart';
import 'package:http_interceptor/http_interceptor.dart';

class UserService {
  final SecureStorage secureStorage = SecureStorage();

  Future<Profile?> getProfile(
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');
    final userId = decodeJwt(jwt);

    try {
      var response = await http.get(
        Uri.parse('$api/$userId/profile'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        },
      );

      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      return Profile.fromJson(jsonDecode(response.body));
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile is not exist.'),
        ),
      );

      return null;
    }
  }

  Future<User?> getUser(
    BuildContext context,
  ) async {
    final jwt = await secureStorage.readSecureData('jwt');
    final id = decodeJwt(jwt);

    try {
      final response = await http.get(
        "$api/user/$id".toUri(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        },
      );
      print(response);

      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      return User.fromJson(jsonDecode(response.body));
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is not exist.'),
        ),
      );

      return null;
    }
  }
}
