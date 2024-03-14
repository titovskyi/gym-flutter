import 'package:flutter/material.dart';

class GymTextFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool autocorrect;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Function? validate;
  final Function onSaved;
  final int maxLines;

  const GymTextFormField({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.autocorrect = false,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.validate,
    required this.onSaved,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.yellow,
          backgroundColor: Color.fromARGB(255, 80, 83, 80),
        ),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: const Color.fromARGB(255, 80, 83, 80),
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      validator: (value) {
        if (validate != null) {
          return validate!(value);
        }

        return null;
      },
      onSaved: (value) {
        onSaved(value);
      },
    );
  }
}
