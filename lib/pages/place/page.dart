import 'package:flutter/material.dart';
import 'package:hanet/layout/app_layout.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Container(
        child: Text("Place Page"),
      ),
    );
  }
}
