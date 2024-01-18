import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/role.enum.dart';
import 'package:http/http.dart' as http;

import 'package:gym_logger_2/constants/api.constants.dart';

import 'package:gym_logger_2/services/storage.service.dart';

class AuthService {
  final SecureStorage secureStorage = SecureStorage();

  void showAuthErrorSnackbar(context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Authentication faild.'),
      ),
    );
  }

  Future<String?> signup(
    String email,
    String password,
    Role role,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$api/signup'),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
            'role': role.index,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      await secureStorage.writeSecureData('jwt', response.body);

      return response.body;
    } catch (err) {
      showAuthErrorSnackbar(context);

      return null;
    }
  }

  Future<String?> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$api/login'),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      await secureStorage.writeSecureData('jwt', response.body);

      return response.body;
    } catch (err) {
      showAuthErrorSnackbar(context);

      return null;
    }
  }
}
