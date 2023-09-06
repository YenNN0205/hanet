import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hanet/models/attendance/attendance.d.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/attendance_status.e.dart';

import 'package:hanet/models/person/person.d.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../components/StatusCard.dart';
import '../../controllers/person/person.ctrl.dart';
import '../constants/styles.c.dart';

class AttendanceDataSource extends DataGridSource {
  final List<HanetCheckIn> checkIns;
  late final Map<String, Attendance> attendanceMap;
  final List<HanetPerson> peopleList;

  AttendanceDataSource({required this.checkIns, required this.peopleList}) {
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
  // static const timeOptions = {
  //   "hourCycle": 'h23',
  //   "hour": '2-digit',
  //   "minute": '2-digit'
  // };

  //process checkin data
  void handleCheckInData() {
    attendanceMap = <String, Attendance>{};
    final people = peopleList;
    print("Checkin passing get: ${checkIns.length}");
    for (var person in people) {
      try {
        String personID = person.personID ?? "";
        Attendance attendance = Attendance();
        final checkInListByPerson =
            checkIns.where((e) => e.personID == personID).toList();

        attendance.person = person;
        List<DateTime> checkTimes = [];
        for (var checkIn in checkInListByPerson) {
          checkTimes.add(
              DateTime.fromMillisecondsSinceEpoch(checkIn.checkinTime ?? 0));
        }
        // assgin check-in and check-out data
        if (checkTimes.isNotEmpty) {
          attendance.checkIn = checkTimes[0];
          if (checkTimes.length > 1) {
            // sort desc
            checkTimes.sort((a, b) => a.compareTo(b));
            attendance.checkIn = checkTimes[0];
            attendance.checkOut = checkTimes[checkTimes.length - 1];
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
                padding: const EdgeInsets.symmetric(vertical: 4),
                alignment: Alignment.center,
                child: Text(
                  attTime != null
                      ? DateFormat("HH:mm:ss").format(attTime)
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
