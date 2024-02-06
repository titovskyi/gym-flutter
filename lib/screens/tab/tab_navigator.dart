import 'package:flutter/material.dart';
import 'package:gym_logger_2/screens/calendar/calendar.dart';
import 'package:gym_logger_2/screens/profile/profile.dart';
import 'package:gym_logger_2/screens/training/new_training.dart';

class TabNavigator extends StatelessWidget {
  GlobalKey<NavigatorState>? navigatorKey;
  int tabItem = 0;

  TabNavigator({
    super.key,
    this.navigatorKey,
    required this.tabItem,
  });
  // TODO have to be moved to one Enum
  List<String> routes = [
    '/',
    '/new-training',
    '/profile',
  ];

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      '/': (context) => const CalendarScreen(),
      '/new-training': (context) => const NewTrainingScreen(),
      '/profile': (context) => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: routes[tabItem],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) {
          return routeBuilders[routeSettings.name]!(context);
        });
      },
    );
  }
}
