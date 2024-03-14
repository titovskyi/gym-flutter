import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GymLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const GymLayout({
    super.key,
    required this.title,
    required this.leading,
    required this.actions,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: leading,
        actions: actions,
      ),
      body: body,
    );
  }
}
