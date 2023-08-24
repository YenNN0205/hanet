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

class TrafficDataSource extends DataGridSource {
  final List<HanetCheckIn> checkIns;

  TrafficDataSource({required this.checkIns}) {
    _trafficRows = checkIns.map((e) {
      return DataGridRow(cells: [
        DataGridCell(columnName: "id", value: e.personID),
        DataGridCell(columnName: "picture", value: e.avatar),
        DataGridCell(columnName: "name", value: e.personName),
        DataGridCell(columnName: "check_in", value: e.checkinTime),
        DataGridCell(columnName: "classification", value: e.type),
      ]);
    }).toList();
  }

  late final List<DataGridRow> _trafficRows;

  @override
  List<DataGridRow> get rows => _trafficRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Colors.white,
        cells: row.getCells().map((e) {
          String columnName = e.columnName;
          switch (columnName) {
            case "id":
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  e.value,
                  style: HanetTextStyles.cellText,
                ),
              );
            case "picture":
              return Container(
                height: 64,
                width: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(e.value),
                    ),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    )),
                padding: EdgeInsets.symmetric(vertical: 4),
              );

            case "name":
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  e.value,
                  style: HanetTextStyles.cellText,
                ),
              );
            case "check_in":
              DateTime d = DateTime.fromMillisecondsSinceEpoch(e.value ?? 0);
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat("hh:mm:ss").format(d),
                  style: HanetTextStyles.cellText,
                ),
              );
            case "classification":
              int type = e.value;
              String typeText = "";
              Color? typeColor = Colors.white;
              switch (type) {
                case 0:
                  typeText = "Employee";
                  typeColor = Colors.green.shade800;
                  break;

                case 1:
                  typeText = "Customer";
                  typeColor = Colors.indigo.shade700;
                  break;
                default:
                  typeText = "Stranger";
                  typeColor = Colors.red.shade700;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 40, maxWidth: 80),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      typeText,
                      style:
                          HanetTextStyles.cellText.copyWith(color: typeColor),
                    ),
                  ),
                ],
              );
            default:
              return Container();
          }
        }).toList());
  }
}
