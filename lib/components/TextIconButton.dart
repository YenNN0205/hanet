import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final Widget text;
  final Widget icon;
  final Function()? onClick;
  const TextIconButton({
    required this.text,
    required this.icon,
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Row(
        children: [icon, text],
      ),
    );
  }
}
