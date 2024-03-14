import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/widgets/image/image.dart';

class ExerciseTile extends StatefulWidget {
  final Exercise exercise;
  final List<Exercise> checkedWorkouts;
  final Function onTileTap;
  final bool withCheckbox;

  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.checkedWorkouts,
    required this.onTileTap,
    required this.withCheckbox,
  });

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool? isChecked = false;

  @override
  void initState() {
    super.initState();

    if (widget.withCheckbox != false) {
      _isInitChecked();
    }
  }

  void _isInitChecked() {
    isChecked = widget.checkedWorkouts
        .where((el) => el.id == widget.exercise.id)
        .isNotEmpty;
  }

  void _updateIsChecked() {
    widget.onTileTap(widget.exercise);

    setState(() {
      if (widget.withCheckbox) {
        isChecked = !isChecked!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _updateIsChecked,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 80, 83, 80),
          border: Border.all(
            color: Colors.yellow,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: _content(),
      ),
    );
  }

  Widget _exerciseDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.exercise.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Text(
          widget.exercise.subTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _exerciseCheckbox() {
    return Checkbox(
      activeColor: const Color.fromARGB(255, 80, 83, 80),
      checkColor: Colors.yellow,
      value: isChecked,
      onChanged: (bool? value) {
        _updateIsChecked();
      },
    );
  }

  List<Widget> _createSkeleton() {
    List<Widget> widgets = [
      GymImage(
        imagePath: widget.exercise.imagePath ?? '',
      ),
      const SizedBox(width: 10),
      _exerciseDescription(),
    ];

    if (widget.withCheckbox) {
      widgets.insert(0, _exerciseCheckbox());
    }

    return widgets;
  }

  Widget _content() {
    List<Widget> skeleton = _createSkeleton();

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...skeleton],
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
