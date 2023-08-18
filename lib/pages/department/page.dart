import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/PlaceItem.dart';
import 'package:hanet/components/TextIconButton.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/models/constants/colors.c.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/department/department.d.dart';

class DepartmentScreen extends StatelessWidget {
  DepartmentScreen({super.key});

  RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    final placeCtrl = Get.find<PlaceController>();
    if (selectedIndex.value >= 0) {
      print(placeCtrl.departmentsMap);
      print(placeCtrl
          .departmentsMap[placeCtrl.places[selectedIndex.value].id.toString()]);
    }
    return AppLayout(
      child: Container(
        color: HanetColors.contentBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: Text("Add"),
                      icon: Icon(Icons.add),
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                // height: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(
                        maxWidth: 80,
                      ),
                      onPressed: () {
                        selectedIndex.value = -1;
                      },
                      icon: Row(
                        children: [Icon(Icons.chevron_left), Text("Back")],
                      ),
                    ),
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  placeCtrl.places.length,
                                  (index) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print("Update index");
                                              selectedIndex.value = index;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: PlaceItem(
                                                text: Text(placeCtrl
                                                        .places[index].name ??
                                                    ""),
                                                backgroundColor:
                                                    Colors.green.shade200,
                                              ),
                                            ),
                                          ),
                                          index == selectedIndex.value
                                              ? Icon(
                                                  Icons.arrow_right_rounded,
                                                  size: 60,
                                                  color: Colors.green.shade200,
                                                )
                                              : const SizedBox()
                                        ],
                                      )).toList(),
                            ),
                          ),
                          selectedIndex.value >= 0
                              ? Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.blue.shade400,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: (placeCtrl.departmentsMap[
                                                placeCtrl
                                                    .places[selectedIndex.value]
                                                    .id
                                                    .toString()] ??
                                            [])
                                        .map((element) => PlaceItem(
                                            text: Text(
                                                (element as HanetDepartment)
                                                        .name ??
                                                    "")))
                                        .toList(),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
