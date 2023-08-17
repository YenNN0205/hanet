import 'package:flutter/material.dart';

class TrafficTableSection extends StatelessWidget {
  const TrafficTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        color: Colors.red,
        width: 360,
        height: 360,
        child: Text("Traffic table section"),
      ),
    );
  }
}
