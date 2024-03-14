import 'package:flutter/material.dart';

class GymDropdownButtonField extends StatelessWidget {
  final String value;
  final Function onChange;
  final List<DropdownMenuItem<String>> items;

  const GymDropdownButtonField({
    super.key,
    required this.value,
    required this.items,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromARGB(255, 80, 83, 80),
      ),
      child: DropdownButtonFormField(
        value: value,
        items: items,
        onChanged: (newValue) {
          onChange(newValue);
        },
        style: const TextStyle(
          color: Colors.yellow,
          backgroundColor: Color.fromARGB(255, 80, 83, 80),
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 80, 83, 80),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    );
  }
}
