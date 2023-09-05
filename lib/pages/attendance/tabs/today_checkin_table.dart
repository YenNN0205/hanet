import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/controllers/person/person.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/models/attendance/attendance_data_source.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/person/person.d.dart';
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
  RxBool isLoading = false.obs;
  late RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  late final AttendanceController attendanceCtrl;
  late final PersonController personCtrl;
  @override
  void initState() {
    super.initState();
    attendanceCtrl = Get.find<AttendanceController>();
    personCtrl = Get.find<PersonController>();

    getCheckInData();
  }

  void getCheckInData() async {
    isLoading.value = true;
    var checkInList =
        await attendanceCtrl.getCheckInListInTimestamp(placeID: widget.placeID);
    checkIns.clear();
    checkIns.addAll(checkInList);
    isLoading.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SfDataGrid(
          source: AttendanceDataSource(
              checkIns: checkIns,
              peopleList:
                  personCtrl.peopleMap[widget.placeID] ?? <HanetPerson>[]),
          columns: [
            GridColumn(
              width: 100,
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
                columnWidthMode: ColumnWidthMode.none,
                allowSorting: true,
                width: 120,
                columnName: "time_in",
                label: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text("Time in",
                        style: HanetTextStyles.columnTitle))),
            GridColumn(
                columnName: "time_out",
                minimumWidth: 120,
                columnWidthMode: ColumnWidthMode.none,
                allowSorting: true,
                label: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child:
                        Text("Time out", style: HanetTextStyles.columnTitle))),
            GridColumn(
                columnName: "status",
                columnWidthMode: ColumnWidthMode.fitByCellValue,
                allowSorting: true,
                width: 100,
                label: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text("Satus", style: HanetTextStyles.columnTitle))),
          ]),
    );
  }
}
