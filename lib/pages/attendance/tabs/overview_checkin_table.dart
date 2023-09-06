import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/models/attendance/attendace_month_data_source.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/place/place.d.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OverviewCheckInTable extends StatefulWidget {
  // final DateTime pickedMonth;
  final String placeID;
  const OverviewCheckInTable({
    super.key,
    required this.placeID,
    // required this.pickedMonth,
  });

  @override
  State<OverviewCheckInTable> createState() => _OverviewCheckInTableState();
}

class _OverviewCheckInTableState extends State<OverviewCheckInTable> {
  late RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  late final AttendanceController attendanceCtrl;
  late int daysInMonth = 31;
  RxBool isLoading = false.obs;
  late Rx<DateTime> pickedMonth;

  onDatePickedTap() async {
    final pickedVal = await showMonthYearPicker(
        context: context,
        initialDate: pickedMonth.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(const Duration(days: 365 * 50)));
    if (pickedVal != null) {
      pickedMonth.value = pickedVal;
    }
    getCheckInData();
  }

  @override
  void initState() {
    print("init overview");
    super.initState();
    attendanceCtrl = Get.find<AttendanceController>();
    pickedMonth = DateTime.now().copyWith(day: 1).obs;
    // getCheckInData();
  }

  void getCheckInData() {
    isLoading.value = true;
    daysInMonth = DateUtils.getDaysInMonth(
        pickedMonth.value.year, pickedMonth.value.month);
    attendanceCtrl
        .getCheckInListInTimestamp(
      placeID: widget.placeID,
      from: pickedMonth.value.copyWith(day: 1).millisecondsSinceEpoch,
      to: pickedMonth.value.copyWith(day: daysInMonth).millisecondsSinceEpoch,
    )
        .then((checkInList) {
      print("Check in data get: " + checkInList.length.toString());
      checkIns.clear();
      checkIns.addAll(checkInList);
      isLoading.value = false;
    });
  }

  GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    getCheckInData();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 40,
              ),
              margin: const EdgeInsets.only(bottom: 16),
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black87, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: -12,
                      blurRadius: 8,
                    )
                  ]),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                IconButton(
                  onPressed: () {
                    var currentPicked = pickedMonth.value;
                    currentPicked =
                        currentPicked.subtract(const Duration(days: 28));
                    pickedMonth.value = DateUtils.dateOnly(
                        DateTime(currentPicked.year, currentPicked.month, 1));
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: onDatePickedTap,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                              border: Border.symmetric(
                                  vertical: BorderSide(
                                      width: 0.5, color: Colors.black87))),
                          alignment: Alignment.center,
                          child: Text(
                              DateFormat("MMMM y").format(pickedMonth.value)),
                        ),
                      )),
                ),
                IconButton(
                  onPressed: () {
                    var currentPicked = pickedMonth.value;
                    currentPicked = currentPicked.add(const Duration(days: 31));
                    pickedMonth.value = DateUtils.dateOnly(
                        DateTime(currentPicked.year, currentPicked.month, 1));
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                ),
              ]),
            ),
          ],
        ),
        Obx(
          () => isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : SfDataGrid(
                  key: key,
                  source: AttendanceMonthDataSource(
                      pickedMonth: pickedMonth.value,
                      placeID: widget.placeID,
                      checkIns: checkIns),
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
                                style: HanetTextStyles.columnTitle)),
                      ),
                      ...List.generate(
                        daysInMonth,
                        (index) => GridColumn(
                          columnWidthMode: ColumnWidthMode.auto,
                          columnName: (index + 1).toString(),
                          width: 50,
                          allowSorting: true,
                          label: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text((index + 1).toString(),
                                style: HanetTextStyles.columnTitle),
                          ),
                        ),
                      )
                    ]),
        ),
      ],
    );
  }
}
