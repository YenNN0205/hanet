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

import '../../controllers/place/place.ctrl.dart';
import '../../models/place/place.d.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final attendanceCtrl = Get.find<AttendanceController>();

  RxInt selectedPlaceIndex = (-1).obs;
  late final List<HanetPlace> places;

  RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  @override
  void initState() {
    super.initState();
    getCheckInData();
  }

  void getCheckInData() {
    final placeCtrl = Get.find<PlaceController>();
    places = placeCtrl.places;

    if (places.isNotEmpty) {
      selectedPlaceIndex.value = 0;
      String placeID = places[selectedPlaceIndex.value].id.toString();
      attendanceCtrl
          .getCheckInListInTimestamp(placeID: placeID)
          .then((checkInList) {
        checkIns.clear();
        checkIns.addAll(checkInList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SingleChildScrollView(
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
                            child: DropdownButton<int>(
                                hint: Text(
                                  "Place...",
                                  style: HanetTextStyles.buttonText
                                      .copyWith(color: Colors.grey),
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                underline: const SizedBox(),
                                value: selectedPlaceIndex.value >= 0
                                    ? selectedPlaceIndex.value
                                    : null,
                                padding: EdgeInsets.zero,
                                items: List.generate(
                                  places.length,
                                  (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      places[index].name ?? "",
                                      style: HanetTextStyles.buttonText
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  selectedPlaceIndex.value = val ?? -1;
                                }),
                          ),
                        )
                      ]),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          constraints:
                              BoxConstraints(maxHeight: Get.size.height),
                          child: SfDataGrid(
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
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnWidthMode:
                                        ColumnWidthMode.fitByCellValue,
                                    allowSorting: true,
                                    minimumWidth: 100,
                                    columnName: "time_in",
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: const Text("Time in",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnName: "time_out",
                                    minimumWidth: 150,
                                    columnWidthMode: ColumnWidthMode.fill,
                                    allowSorting: true,
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: Text("Time out",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnName: "status",
                                    columnWidthMode:
                                        ColumnWidthMode.fitByCellValue,
                                    allowSorting: true,
                                    minimumWidth: 200,
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: Text("Satus",
                                            style:
                                                HanetTextStyles.columnTitle))),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
