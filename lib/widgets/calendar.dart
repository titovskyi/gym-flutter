import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_logger_2/constants/calendar.dart';
import 'package:gym_logger_2/providers/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gym_logger_2/models/workout.dart';
import 'package:gym_logger_2/services/workout.service.dart';

import 'package:flutter/material.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  final String uid;

  const CalendarWidget({super.key, required this.uid});

  @override
  ConsumerState<CalendarWidget> createState() {
    return _CalendarWidgetState();
  }
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  late List<Workout> _userWorkouts = [];

  DateTime _focusedDay = kToday;
  DateTime? _selectedDay = kToday;

  void onDaySelected(selectedDay, focusedDay) async {
    // final userWorkouts = await WorkoutService().getAllUserWorkouts(
    //   ref.read(calendarProvider),
    //   widget.uid,
    // );

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    ref.read(calendarProvider.notifier).updateChoosenDate(selectedDay);
  }

  @override
  void initState() {
    super.initState();

    _getUserWorkouts(ref.read(calendarProvider));
  }

  void _getUserWorkouts(DateTime day) async {
    // final userWorkouts = await WorkoutService().getAllUserWorkouts(widget.uid);

    // _userWorkouts = userWorkouts;
  }

  List<Workout> _getEventsForDay(day) {
    // _getUserWorkouts(day);

    return _userWorkouts
        .where(
          (element) =>
              DateTime(
                day.year,
                day.month,
                day.day,
              ) ==
              DateTime(
                element.date!.year,
                element.date!.month,
                element.date!.day,
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        markerBuilder: (BuildContext ctx, data, events) {
          if (events.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 6,
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 255, 26),
                  width: 4,
                ),
                shape: BoxShape.circle,
              ),
            );
          }
        },
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      locale: 'uk',
      focusedDay: _focusedDay,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay, focusedDay);
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      eventLoader: (day) => _getEventsForDay(day),
      headerStyle: const HeaderStyle(
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: const TextStyle(color: Colors.black),
        todayDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF9FA8DA),
            width: 4,
          ),
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.black,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
