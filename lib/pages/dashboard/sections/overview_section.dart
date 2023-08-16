import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        color: Colors.blue,
        width: 360,
        height: 360,
        child: Text("Overview section"),
      ),
    );
  }
}
