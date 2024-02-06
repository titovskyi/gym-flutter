import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gym_logger_2/models/exercise.dart';

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

    _isInitChecked();
  }

  void _isInitChecked() {
    isChecked = widget.checkedWorkouts
        .where((el) => el.id == widget.exercise.id)
        .isNotEmpty;
  }

  List<Widget> _content() {
    List<Widget> widgets = [
      SizedBox(
        width: 60,
        height: 60,
        child: _exerciseImage(),
      ),
      Text(widget.exercise.title),
    ];

    if (widget.withCheckbox) {
      return [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            widget.onTileTap(widget.exercise);

            setState(() {
              isChecked = value;
            });
          },
        ),
        ...widgets,
      ];
    } else {
      return widgets;
    }
  }

  Widget _exerciseImage() {
    if (widget.exercise.imagePath != null) {
      return Image.network(
        widget.exercise.imagePath!,
      );
    }

    return Text('Image');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _content(),
    );
  }
}
