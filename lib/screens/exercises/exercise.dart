import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/widgets/image/image.dart';
import 'package:gym_logger_2/widgets/info-view/info_view.dart';
import 'package:gym_logger_2/widgets/info-view/info_view_type.enum.dart';
import 'package:gym_logger_2/widgets/layout/layout.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<StatefulWidget> createState() {
    return _ExerciseScreenState();
  }
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return GymLayout(
      title: widget.exercise.title,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GymImage(
                width: double.infinity,
                height: 200,
                imagePath: widget.exercise.imagePath ?? '',
              ),
              GymInfoView(
                type: InfoViewType.Text,
                label: 'SubTitle',
                stringValue: widget.exercise.subTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              GymInfoView(
                type: InfoViewType.NumbericList,
                label: 'Equipment',
                listValue: widget.exercise.equipment,
              ),
              const SizedBox(
                height: 10,
              ),
              GymInfoView(
                type: InfoViewType.Text,
                label: 'Preparation',
                stringValue: widget.exercise.preparation,
              ),
              const SizedBox(
                height: 10,
              ),
              GymInfoView(
                type: InfoViewType.NumbericList,
                label: 'Execution',
                listValue: widget.exercise.execution,
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
    //   appBar: AppBar(
    //     backgroundColor: Colors.black,
    //     title: Text(
    //       widget.exercise.title,
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     leading: IconButton(
    //       icon: const Icon(
    //         Icons.chevron_left,
    //         color: Colors.white,
    //       ),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           GymImage(
    //             width: double.infinity,
    //             height: 200,
    //             imagePath: widget.exercise.imagePath ?? '',
    //           ),
    //           GymInfoView(
    //             type: InfoViewType.Text,
    //             label: 'SubTitle',
    //             stringValue: widget.exercise.subTitle,
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           GymInfoView(
    //             type: InfoViewType.NumbericList,
    //             label: 'Equipment',
    //             listValue: widget.exercise.equipment,
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           GymInfoView(
    //             type: InfoViewType.Text,
    //             label: 'Preparation',
    //             stringValue: widget.exercise.preparation,
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           GymInfoView(
    //             type: InfoViewType.NumbericList,
    //             label: 'Execution',
    //             listValue: widget.exercise.execution,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
