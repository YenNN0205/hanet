import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const SearchButton({
    this.controller,
    this.hintText = "Search by name...",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
      width: 180,
      padding: EdgeInsets.only(
        right: 8,
      ),
      child: TextField(
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.search_rounded),
          fillColor: Colors.white,
        ),
        controller: controller,
      ),
    );
  }
}
