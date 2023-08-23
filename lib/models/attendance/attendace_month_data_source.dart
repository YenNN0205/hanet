import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/utils/utils.dart';

import 'package:hanet/models/attendance/attendance.d.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/constants/attendance_status.e.dart';

import 'package:hanet/models/person/person.d.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/person/person.ctrl.dart';
import '../constants/styles.c.dart';

class AttendanceMonthDataSource extends DataGridSource {
  final DateTime pickedMonth;
  final String placeID;
  final List<HanetCheckIn> checkIns;

  late final PersonController personController;
  late final List<HanetPerson> people;
  late List<List<AttendanceStatus>> _attendanceDatas;
  AttendanceMonthDataSource({
    required this.placeID,
    required this.pickedMonth,
    required this.checkIns,
  }) {
    handleCheckInData();
    _attendanceRows = List.generate(people.length, (index) {
      final person = people[index];
      final statusList = _attendanceDatas[index];
      return DataGridRow(cells: [
        DataGridCell(columnName: "profile", value: person.avatar ?? ''),
        DataGridCell(columnName: "name", value: person.name ?? ""),
        ...List.generate(
          statusList.length,
          (index) => DataGridCell(
              columnName: (index + 1).toString(), value: statusList[index]),
        )
      ]);
    });
  }

  late final List<DataGridRow> _attendanceRows;

  @override
  List<DataGridRow> get rows => _attendanceRows;

  //process checkin data
  void handleCheckInData() {
    personController = Get.find<PersonController>();
    people = personController.peopleMap[placeID] ?? <HanetPerson>[];
    final dayInMonth =
        DateUtils.getDaysInMonth(pickedMonth.year, pickedMonth.month);

    _attendanceDatas = List.generate(
        people.length,
        (peopleIndex) =>
            List.generate(dayInMonth, (_) => AttendanceStatus.ABSENT));

    for (int i = 0; i > people.length; i++) {
      try {
        String personID = people[i].personID ?? "";
        // generate list attendance status for person
        List<AttendanceStatus> personStatusList =
            List.generate(dayInMonth, (index) => AttendanceStatus.ABSENT);
        // find all check in map with person
        final checkInListByPerson =
            checkIns.where((e) => e.personID == personID).toList();
        for (var checkIn in checkInListByPerson) {
          DateTime checkInDateTime =
              DateTime.fromMillisecondsSinceEpoch(checkIn.checkinTime ?? 0);
          int statusIndex = checkInDateTime.day - 1;
          if (personStatusList[statusIndex] == AttendanceStatus.ABSENT) {
            if (compareTimeOnly(checkInDateTime, StartWorkingTime) > 0) {
              personStatusList[statusIndex] = AttendanceStatus.LATE;
            } else {
              personStatusList[statusIndex] = AttendanceStatus.PRESENT;
            }
            print(personID + " - " + personStatusList[statusIndex].toString());
          }
          // remove in checkIns data
          checkIns.remove(checkIn);
        }
        // update in attendanceDatas
        _attendanceDatas[i] = personStatusList;
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
          if (columnName == "profile") {
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
          }
          if (columnName == "name") {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                e.value,
                style: HanetTextStyles.cellText,
              ),
            );
          }
          // index column name
          AttendanceStatus status = e.value;
          Color iconColor = Colors.red.shade800;
          IconData iconData = Icons.close_rounded;
          if (status == AttendanceStatus.LATE) {
            iconColor = Colors.yellow.shade800;
            iconData = Icons.directions_run_rounded;
          } else if (status == AttendanceStatus.PRESENT) {
            iconColor = Colors.green.shade700;
            iconData = Icons.check;
          }

          return Container(
            color: iconColor.withOpacity(0.2),
            child: Icon(
              iconData,
              color: iconColor,
            ),
          );
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
