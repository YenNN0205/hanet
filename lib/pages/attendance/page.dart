import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  Rx<String?> selectedPlace = Rx(null);

  final List<String> places = [
    "Ha Noi",
    "Da Nang",
    "Ho Chi Minh City",
  ];
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: DataListLayout(
          title: "Attendance",
          description:
              "Security and safety solutions suitable for residential areas",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchButton(),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.white,
                          child: DropdownButton(
                              hint: Text(
                                "Place...",
                                style: HanetTextStyles.buttonText
                                    .copyWith(color: Colors.grey),
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              underline: const SizedBox(),
                              value: selectedPlace.value,
                              padding: EdgeInsets.zero,
                              items: places
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: HanetTextStyles.buttonText
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                selectedPlace.value = val;
                              }),
                        ),
                      )
                    ]),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                ],
              ),
            ],
          )),
    );
  }
}
