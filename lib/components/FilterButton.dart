import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Function()? onClick;
  const FilterButton({
    this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: Row(
        children: [Icon(Icons.filter_alt_outlined), Text("Filter")],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }
}
