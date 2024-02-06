import 'package:flutter/material.dart';

enum TabItem {
  calendar,
  profile,
}

const Map<TabItem, String> tabName = {
  TabItem.calendar: 'Calendar',
  TabItem.profile: 'Profile',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.calendar: Colors.green,
  TabItem.profile: Colors.blue,
};
