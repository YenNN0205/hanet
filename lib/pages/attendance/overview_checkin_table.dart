import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/models/attendance/attendace_month_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/attendance/checkin.d.dart';
import '../../models/constants/styles.c.dart';

class OverviewCheckInTable extends StatefulWidget {
  final DateTime pickedMonth;
  final String placeID;
  const OverviewCheckInTable({
    super.key,
    required this.placeID,
    required this.pickedMonth,
  });

  @override
  State<OverviewCheckInTable> createState() => _OverviewCheckInTableState();
}

class _OverviewCheckInTableState extends State<OverviewCheckInTable> {
  late RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  late final AttendanceController attendanceCtrl;
  late int daysInMonth = 31;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    print("init overview");
    super.initState();
    attendanceCtrl = Get.find<AttendanceController>();
    daysInMonth = DateUtils.getDaysInMonth(
        widget.pickedMonth.year, widget.pickedMonth.month);
    // getCheckInData();
  }

  void getCheckInData() {
    isLoading.value = true;
    attendanceCtrl
        .getCheckInListInTimestamp(
      placeID: widget.placeID,
      from: widget.pickedMonth.copyWith(day: 1).millisecondsSinceEpoch,
      to: widget.pickedMonth.copyWith(day: daysInMonth).millisecondsSinceEpoch,
    )
        .then((checkInList) {
      print("Check in data get: " + checkInList.length.toString());
      checkIns.clear();
      checkIns.addAll(checkInList);
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Rebuild UI");
    getCheckInData();
    return Obx(
      () => isLoading.value
          ? Container(
              child: CircularProgressIndicator(),
              color: Colors.amber,
            )
          : SfDataGrid(
              source: AttendanceMonthDataSource(
                  pickedMonth: widget.pickedMonth,
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
                        child:
                            Text("Name", style: HanetTextStyles.columnTitle)),
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
    );
  }
}
