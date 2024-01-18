import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:gym_logger_2/screens/calendar.dart';

import 'package:gym_logger_2/screens/auth/auth.dart';
import 'package:gym_logger_2/services/storage.service.dart';

String? jwt;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SecureStorage secureStorage = SecureStorage();
  jwt = await secureStorage.readSecureData('jwt');
  print('jwt $jwt');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget content = const Text('Trainer');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        // primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            63,
            17,
            177,
          ),
        ),
      ),
      initialRoute: jwt == null ? 'login' : '/',
      routes: {
        '/': (contex) => const Calendar(),
        "login": (context) => const AuthScreen(),
      },
    );
  }
}
