import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final Widget text;
  final Color? backgroundColor;
  const PlaceItem({
    required this.text,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: text,
    );
  }
}
