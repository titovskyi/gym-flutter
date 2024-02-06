import 'package:gym_logger_2/screens/app/app.dart';
import 'package:gym_logger_2/screens/auth/auth.dart';
import 'package:gym_logger_2/screens/tab/tab_navigation.dart';

final routes = {
  '/': (contex) => const TabNavigation(),
  'login': (context) => const AuthScreen(),
};
