import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/TextIconButton.dart';
import 'package:hanet/components/PlaceCard.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/models/constants/colors.c.dart';
import 'package:hanet/models/constants/styles.c.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final placeCtrl = Get.find<PlaceController>();

    return AppLayout(
      child: Container(
        color: HanetColors.contentBackground,
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              'Place',
              style: HanetTextStyles.h1Text,
            ),
            Text(
              "Security and safety solutions suitable for residential areas",
              style: HanetTextStyles.h3Text,
              softWrap: true,
              maxLines: 3,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey.shade400,
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchButton(),
                    TextIconButton(
                      text: Text("Filter"),
                      icon: Icon(Icons.filter_alt_outlined),
                    ),
                  ]),
            ),
            Container(
              color: Colors.white,
              constraints: BoxConstraints(maxHeight: Get.size.height - 200),
              width: double.infinity,
              // height: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: placeCtrl.places
                    .map((place) => PlaceCard(
                          place: place,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
