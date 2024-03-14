import 'package:flutter/material.dart';

class GymElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;

  const GymElevatedButton({
    super.key,
    required this.child,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: child,
    );
  }
}
