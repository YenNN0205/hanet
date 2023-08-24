import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/constants/styles.c.dart';
import '../models/place/place.d.dart';

class PlaceDropdown extends StatelessWidget {
  const PlaceDropdown({
    super.key,
    required this.selectedPlaceIndex,
    required this.places,
    this.onChanged,
  });

  final int selectedPlaceIndex;
  final List<HanetPlace> places;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: DropdownButton<int>(
          hint: Text(
            "Place...",
            style: HanetTextStyles.buttonText.copyWith(color: Colors.grey),
          ),
          icon: Icon(Icons.arrow_drop_down),
          underline: const SizedBox(),
          value: selectedPlaceIndex >= 0 ? selectedPlaceIndex : null,
          padding: EdgeInsets.zero,
          items: List.generate(
            places.length,
            (index) => DropdownMenuItem(
              value: index,
              child: Text(
                places[index].name ?? "",
                style: HanetTextStyles.buttonText.copyWith(color: Colors.black),
              ),
            ),
          ),
          onChanged: onChanged,
        ));
  }
}
