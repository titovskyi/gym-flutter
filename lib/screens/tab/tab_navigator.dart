import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/providers/bottom_navigation.provider.dart';
import 'package:gym_logger_2/screens/calendar/calendar.dart';
import 'package:gym_logger_2/screens/exercises/exercises.dart';
import 'package:gym_logger_2/screens/profile/profile.dart';
import 'package:gym_logger_2/screens/tab/tab_item.dart';
import 'package:gym_logger_2/screens/training/trainings.dart';

class TabNavigator extends ConsumerWidget {
  GlobalKey<NavigatorState>? navigatorKey;
  int tabItem = 0;

  TabNavigator({
    super.key,
    this.navigatorKey,
    required this.tabItem,
  });

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      tabItemRoute[TabItem.trainings]!: (context) => const TrainingsScreen(),
      tabItemRoute[TabItem.exercises]!: (context) => const ExercisesScreen(
            exercises: [],
            withoutBackButton: true,
          ),
      tabItemRoute[TabItem.calendar]!: (context) => const CalendarScreen(),
      tabItemRoute[TabItem.profile]!: (context) => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: tabItemRoute[TabItem.values[tabItem]],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) {
          return routeBuilders[routeSettings.name]!(context);
        });
      },
    );
  }
}
