import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/screens/tab/tab_item.dart';

class BottomNavbarNotifier extends StateNotifier<int> {
  BottomNavbarNotifier() : super(TabItem.calendar.index);

  void updateChoosenTab(int index) {
    state = index;
  }
}

final indexBottomNavbarProvider =
    StateNotifierProvider<BottomNavbarNotifier, int>(
        (ref) => BottomNavbarNotifier());
