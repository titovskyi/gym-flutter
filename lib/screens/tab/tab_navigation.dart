import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/providers/bottom_navigation.provider.dart';
import 'package:gym_logger_2/screens/tab/tab_item.dart';
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
    GlobalKey<NavigatorState>(),
  ];

  int currentPage = 0;

  void _selectTab(int tabItem) {
    setState(() {
      currentPage = tabItem;
      ref.watch(indexBottomNavbarProvider.notifier).updateChoosenTab(tabItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildOffstageNavigator(TabItem.trainings.index),
          _buildOffstageNavigator(TabItem.exercises.index),
          _buildOffstageNavigator(TabItem.calendar.index),
          _buildOffstageNavigator(TabItem.profile.index),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Color.fromARGB(255, 80, 83, 80),
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: tabName[TabItem.trainings],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: tabName[TabItem.exercises],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_view_day),
            label: tabName[TabItem.calendar],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: tabName[TabItem.profile],
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
