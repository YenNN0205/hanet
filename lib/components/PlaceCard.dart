import 'package:flutter/material.dart';
import 'package:hanet/models/place/place.d.dart';

class PlaceCard extends StatelessWidget {
  final HanetPlace place;
  const PlaceCard({
    required this.place,
    super.key,
  });

  static const TextStyle cardText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w300,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFF3F3F4),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name ?? "",
                style: cardText.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text(
                place.address ?? "",
                style: cardText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "01 Device",
                style: cardText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Icon(Icons.keyboard_double_arrow_right)
            ],
          )
        ],
      ),
    );
  }
}
