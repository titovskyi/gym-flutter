import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/providers/bottom_navigation.provider.dart';
import 'package:gym_logger_2/screens/tab/tab_navigator.dart';

class TabNavigation extends ConsumerStatefulWidget {
  const TabNavigation({super.key});

  @override
  ConsumerState<TabNavigation> createState() => TabNavigationState();
}

class TabNavigationState extends ConsumerState<TabNavigation> {
  final navigatorKey = GlobalKey<NavigatorState>();

  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int currentPage = 0;
  // TODO have to be updated to start use Enum
  List<String> routes = [
    '/',
    '/new-training',
    '/profile',
  ];

  void _selectTab(int tabItem) {
    setState(() {
      currentPage = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // TODO have to be updated to start use Enum
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trainings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: currentPage,
        onTap: (val) {
          _selectTab(val);
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(int tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
