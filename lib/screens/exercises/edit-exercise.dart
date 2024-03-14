import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/exercise-type.enum.dart';
import 'package:gym_logger_2/models/exercise.dart';
import 'package:gym_logger_2/services/exercise.service.dart';
import 'package:gym_logger_2/widgets/buttons/elevated_button.dart';
import 'package:gym_logger_2/widgets/form-controls/dropdown_button_field.dart';
import 'package:gym_logger_2/widgets/form-controls/text_form_field.dart';
import 'package:gym_logger_2/widgets/layout/layout.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({super.key});

  @override
  State<EditExerciseScreen> createState() {
    return _EditExerciseScreenState();
  }
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  final _form = GlobalKey<FormState>();

  String _title = '';
  String _subTitle = '';
  List<String> _equipment = [];
  String _preparation = '';
  List<String> _execution = [];
  String _imagePath = '';
  String _type = ExerciseType.Weight.name;

  @override
  Widget build(BuildContext context) {
    return GymLayout(
      title: 'Create Exercise',
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: _submit,
          icon: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                GymTextFormField(
                  label: 'Title',
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GymTextFormField(
                  label: 'Sub Title',
                  onSaved: (value) {
                    _subTitle = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GymTextFormField(
                  label: 'Equipment',
                  maxLines: 4,
                  onSaved: (value) {
                    _equipment = value.split(', ');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GymTextFormField(
                  label: 'Preparation',
                  onSaved: (value) {
                    _preparation = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GymTextFormField(
                  label: 'Execution',
                  maxLines: 4,
                  onSaved: (value) {
                    _execution = value.split(', ');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GymDropdownButtonField(
                  value: _type,
                  items: [
                    ExerciseType.Weight.name,
                    ExerciseType.Time.name,
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChange: (newValue) {
                    setState(() {
                      _type = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
    //   appBar: AppBar(
    //     backgroundColor: Colors.black,
    //     title: const Text(
    //       'Create Exercise',
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
    //     actions: [
    //       IconButton(
    //         onPressed: _submit,
    //         icon: const Icon(
    //           Icons.done,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Form(
    //         key: _form,
    //         child: Column(
    //           children: [
    //             GymTextFormField(
    //               label: 'Title',
    //               onSaved: (value) {
    //                 _title = value;
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             GymTextFormField(
    //               label: 'Sub Title',
    //               onSaved: (value) {
    //                 _subTitle = value;
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             GymTextFormField(
    //               label: 'Equipment',
    //               maxLines: 4,
    //               onSaved: (value) {
    //                 _equipment = value.split(', ');
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             GymTextFormField(
    //               label: 'Preparation',
    //               onSaved: (value) {
    //                 _preparation = value;
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             GymTextFormField(
    //               label: 'Execution',
    //               maxLines: 4,
    //               onSaved: (value) {
    //                 _execution = value.split(', ');
    //               },
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             GymDropdownButtonField(
    //               value: _type,
    //               items: [
    //                 ExerciseType.Weight.name,
    //                 ExerciseType.Time.name,
    //               ].map<DropdownMenuItem<String>>((String value) {
    //                 return DropdownMenuItem<String>(
    //                   value: value,
    //                   child: Text(
    //                     value,
    //                     style: const TextStyle(fontSize: 20),
    //                   ),
    //                 );
    //               }).toList(),
    //               onChange: (newValue) {
    //                 setState(() {
    //                   _type = newValue!;
    //                 });
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    print(_title);

    final exerciseId = await ExerciseService().create(
      Exercise(
        title: _title,
        subTitle: _subTitle,
        equipment: _equipment,
        preparation: _preparation,
        execution: _execution,
        imagePath: _imagePath,
        type: _type == ExerciseType.Weight.name
            ? ExerciseType.Weight
            : ExerciseType.Time,
      ),
      context,
    );

    Navigator.of(context).pop();
  }
}
