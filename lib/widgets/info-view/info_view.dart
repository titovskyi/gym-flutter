import 'package:flutter/material.dart';
import 'package:gym_logger_2/widgets/info-view/info_view_type.enum.dart';

class GymInfoView extends StatelessWidget {
  final String? label;
  final InfoViewType type;
  final String? stringValue;
  final List<String>? listValue;

  const GymInfoView({
    super.key,
    required this.type,
    this.label,
    this.stringValue,
    this.listValue,
  });

  List<Widget> _skeleton() {
    List<Widget> widgets = [];

    if (label != null)
      widgets.add(Text(
        label!,
        style: const TextStyle(
          color: Colors.white,
        ),
      ));

    if (type == InfoViewType.Text && stringValue != null) {
      widgets.add(
        Text(
          stringValue!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    if (type == InfoViewType.NumbericList && listValue != null) {
      print(listValue);
      widgets.add(
        Column(
          children: [
            for (int i = 0; i < listValue!.length; i++)
              Row(
                children: [
                  Text(
                    (i + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    listValue![i],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _skeleton(),
    );
  }
}
