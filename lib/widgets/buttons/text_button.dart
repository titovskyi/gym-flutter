import 'package:flutter/material.dart';

class GymTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;

  const GymTextButton({
    super.key,
    required this.child,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: child,
    );
  }
}
