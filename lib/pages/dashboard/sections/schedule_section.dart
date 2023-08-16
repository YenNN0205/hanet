import 'package:flutter/material.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        color: Colors.green,
        width: 360,
        height: 360,
        child: Text("Schedule section"),
      ),
    );
  }
}
