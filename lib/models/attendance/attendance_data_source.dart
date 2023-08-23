import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hanet/models/attendance/attendance.d.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/attendance_status.e.dart';

import 'package:hanet/models/person/person.d.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/person/person.ctrl.dart';
import '../constants/styles.c.dart';

class AttendanceDataSource extends DataGridSource {
  final List<HanetCheckIn> checkIns;
  late final Map<String, Attendance> attendanceMap;
  late final PersonController personController;
  AttendanceDataSource({required this.checkIns}) {
    handleCheckInData();
    _attendanceRows = attendanceMap.values.map((e) {
      AttendanceStatus status = AttendanceStatus.PRESENT;

      if (e.checkIn == null && e.checkOut == null) {
        status = AttendanceStatus.ABSENT;
      } else if (e.checkIn != null) {
        //TODO: HANDLE copy with later
        if (e.checkIn!.microsecondsSinceEpoch >
            e.checkIn!
                .copyWith(hour: 9, minute: 0, second: 0)
                .microsecondsSinceEpoch) {
          status = AttendanceStatus.LATE;
        }
      }

      return DataGridRow(cells: [
        DataGridCell(columnName: "profile", value: e.person!.avatar ?? ''),
        DataGridCell(columnName: "name", value: e.person!.name ?? ""),
        DataGridCell(columnName: "time_in", value: e.checkIn),
        DataGridCell(columnName: "time_out", value: e.checkOut),
        DataGridCell(columnName: "status", value: status),
      ]);
    }).toList();
  }

  late final List<DataGridRow> _attendanceRows;

  @override
  List<DataGridRow> get rows => _attendanceRows;

  //process checkin data
  void handleCheckInData() {
    attendanceMap = <String, Attendance>{};
    personController = Get.find<PersonController>();
    //TODO: handle error later
    final people = personController.peopleMap['18265'] ?? <HanetPerson>[];
    for (var person in people) {
      try {
        String personID = person.personID ?? "";
        Attendance attendance = Attendance();
        final checkInListByPerson =
            checkIns.where((e) => e.personID == personID).toList();

        attendance.person = person;
        for (var checkIn in checkInListByPerson) {
          // assign data
          DateTime checkinTime =
              DateTime.fromMillisecondsSinceEpoch(checkIn.checkinTime ?? 0);
          if (attendance.checkIn == null) {
            attendance.checkIn = checkinTime;
          } else {
            attendance.checkOut = checkinTime;
          }
        }
        // print(attendance.toJson());
        // put to map
        attendanceMap[personID] = attendance;
      } catch (e) {
        print("Error convert attendance");
        print(e);
      }
    }
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Colors.white,
        cells: row.getCells().map((e) {
          String columnName = e.columnName;
          switch (columnName) {
            case "profile":
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    e.value as String,
                  ),
                ),
              );
            case "name":
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  e.value,
                  style: HanetTextStyles.cellText,
                ),
              );

            case "time_in":
            case "time_out":
              DateTime? attTime = e.value;

              return Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  attTime != null
                      ? DateFormat("hh:mm:ss").format(attTime)
                      : "--:--:--",
                  style: HanetTextStyles.cellText,
                ),
              );
            case "status":
              return StatusCard(
                status: e.value as AttendanceStatus,
              );
            default:
              return Container();
          }
        }).toList());
  }
}

class StatusCard extends StatelessWidget {
  static const TextStyle statusStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  final AttendanceStatus status;
  const StatusCard({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    String label = "Present";
    Color backgroundColor = Colors.green.shade900;
    switch (status) {
      case AttendanceStatus.ABSENT:
        label = "Absent";
        backgroundColor = Colors.red.shade800;
        break;
      case AttendanceStatus.LATE:
        label = "Late";
        backgroundColor = Colors.yellow.shade600;
        break;
      default:
    }
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 80, maxHeight: 30),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: statusStyle.copyWith(color: backgroundColor),
        ),
      ),
    );
  }
}
