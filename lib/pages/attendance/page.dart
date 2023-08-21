import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';
import 'package:hanet/models/attendance/attendance_data_source.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final attendanceCtrl = Get.find<AttendanceController>();

  Rx<String?> selectedPlace = Rx(null);

  final List<String> places = [
    "Ha Noi",
    "Da Nang",
    "Ho Chi Minh City",
  ];

  RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  @override
  void initState() {
    super.initState();
    getCheckInData();
  }

  void getCheckInData() {
    attendanceCtrl
        .getCheckInListInTimestamp(placeID: "18265")
        .then((checkInList) {
      checkIns.clear();
      checkIns.addAll(checkInList);
    });
  }

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
                  Expanded(
                    child: Obx(
                      () => SfDataGrid(
                          source: AttendanceDataSource(checkIns: checkIns),
                          columns: [
                            GridColumn(
                              width: 80,
                              columnName: "profile",
                              label: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Profile",
                                  style: HanetTextStyles.columnTitle,
                                ),
                              ),
                            ),
                            GridColumn(
                                columnWidthMode: ColumnWidthMode.fill,
                                columnName: "name",
                                minimumWidth: 150,
                                allowSorting: true,
                                label: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: Text("Name",
                                        style: HanetTextStyles.columnTitle))),
                            GridColumn(
                                columnWidthMode: ColumnWidthMode.fitByCellValue,
                                allowSorting: true,
                                minimumWidth: 100,
                                columnName: "time_in",
                                label: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: const Text("Time in",
                                        style: HanetTextStyles.columnTitle))),
                            GridColumn(
                                columnName: "time_out",
                                minimumWidth: 150,
                                columnWidthMode: ColumnWidthMode.fill,
                                allowSorting: true,
                                label: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: Text("Time out",
                                        style: HanetTextStyles.columnTitle))),
                            GridColumn(
                                columnName: "status",
                                columnWidthMode: ColumnWidthMode.fitByCellValue,
                                allowSorting: true,
                                minimumWidth: 200,
                                label: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: Text("Satus",
                                        style: HanetTextStyles.columnTitle))),
                          ]),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
