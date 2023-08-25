import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/models/attendance/attendance_data_source.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TodayCheckInTable extends StatefulWidget {
  final String placeID;
  const TodayCheckInTable({
    super.key,
    required this.placeID,
  });

  @override
  State<TodayCheckInTable> createState() => _TodayCheckInTableState();
}

class _TodayCheckInTableState extends State<TodayCheckInTable> {
  late List<HanetCheckIn> checkIns = [];
  late final AttendanceController attendanceCtrl;
  @override
  void initState() {
    super.initState();

    attendanceCtrl = Get.find<AttendanceController>();
  }

  void getCheckInData() {
    attendanceCtrl
        .getCheckInListInTimestamp(placeID: widget.placeID)
        .then((checkInList) {
      checkIns.clear();
      checkIns.addAll(checkInList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
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
                  child: Text("Name", style: HanetTextStyles.columnTitle))),
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
                  child: Text("Time out", style: HanetTextStyles.columnTitle))),
          GridColumn(
              columnName: "status",
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              allowSorting: true,
              width: 100,
              label: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text("Satus", style: HanetTextStyles.columnTitle))),
        ]);
  }
}
