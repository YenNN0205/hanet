import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'employee.d.dart';

class EmployeeDataSource extends DataGridSource {
  late final List<Employee> employees;

  static const TextStyle cellText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  List<DataGridRow> _employeeRows = [];

  List<DataGridRow> get rows => _employeeRows;

  EmployeeDataSource({required this.employees}) {
    _employeeRows = employees
        .map((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'profile', value: e.profile),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'postion', value: e.postion),
              DataGridCell<String>(
                  columnName: 'categorize', value: e.categorize),
              DataGridCell<String>(
                  columnName: 'department', value: e.department),
              DataGridCell(columnName: 'actions', value: e.name),
            ]))
        .toList();
  }
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Colors.white,
        cells: row.getCells().map((e) {
          if (e.columnName == "actions") {
            return Container(
              child: Row(children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ]),
            );
          }
          if (e.columnName == "profile") {
            //TODO: replace employee image url with real data
            return Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
              ),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              e.value,
              style: cellText,
            ),
          );
        }).toList());
  }
}
