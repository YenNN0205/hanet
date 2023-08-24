import 'package:flutter/material.dart';

import '../models/constants/attendance_status.e.dart';

class StatusCard extends StatelessWidget {
  static const TextStyle statusStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  final AttendanceStatus status;
  const StatusCard({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    String label = "Present";
    Color backgroundColor = Colors.green.shade900;
    switch (status) {
      case AttendanceStatus.ABSENT:
        label = "Absent";
        backgroundColor = Colors.red.shade800;
        break;
      case AttendanceStatus.LATE:
        label = "Late";
        backgroundColor = Colors.yellow.shade600;
        break;
      default:
    }
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 80, maxHeight: 30),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: statusStyle.copyWith(color: backgroundColor),
        ),
      ),
    );
  }
}
