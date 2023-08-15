import 'package:flutter/material.dart';
import 'package:hanet/layout/app_layout.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Container(
        child: Text("Employee Page"),
      ),
    );
  }
}
