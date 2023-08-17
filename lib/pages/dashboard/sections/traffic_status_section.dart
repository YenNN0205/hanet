import 'package:flutter/material.dart';

class TrafficStatusSection extends StatelessWidget {
  const TrafficStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        color: Colors.yellow,
        width: 360,
        height: 360,
        child: Text("Traffic status section"),
      ),
    );
  }
}
