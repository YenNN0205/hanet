import 'package:flutter/material.dart';
import 'package:hanet/models/constants/colors.c.dart';
import 'package:hanet/models/constants/styles.c.dart';

class DataListLayout extends StatelessWidget {
  final String title;
  final String description;
  final Widget body;
  const DataListLayout({
    required this.body,
    this.title = "",
    this.description = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HanetColors.contentBackground,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: HanetTextStyles.h1Text,
          ),
          Text(
            description,
            style: HanetTextStyles.h3Text,
            softWrap: true,
            maxLines: 3,
          ),
          Divider(
            height: 1.0,
            color: Colors.grey.shade400,
          ),
          body,
        ],
      ),
    );
  }
}
