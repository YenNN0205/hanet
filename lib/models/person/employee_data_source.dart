import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/department/department.d.dart';
import 'package:hanet/models/person/person.d.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'employee.d.dart';

class EmployeeDataSource extends DataGridSource {
  late final List<Employee> employees;

  List<DataGridRow> _employeeRows = [];

  @override
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
            String profileURL = "";
            if (e.value != null) {
              profileURL = e.value.toString();
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  profileURL,
                ),
              ),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              e.value,
              style: HanetTextStyles.cellText,
            ),
          );
        }).toList());
  }

  // ensure people in same place
  static List<Employee> convertListPersonInPlace(List<HanetPerson> people) {
    List<Employee> ret = <Employee>[];

    if (people.isNotEmpty) {
      final placeId = people[0].placeID ?? 0;
      final departmentList =
          Get.find<PlaceController>().departmentsMap[placeId.toString()] ??
              <HanetDepartment>[];

      print(departmentList.length);
      HanetDepartment defaultDepartment = HanetDepartment(name: "");
      for (var person in people) {
        HanetDepartment? department = departmentList
            .firstWhereOrNull((element) => (element.id == person.departmentID));

        //add employee to ret

        Employee employee = EmployeeBuilder.fromPersonAndDepartment(
            person, department ?? defaultDepartment);
        ret.add(employee);
      }
    }

    return ret;
  }
}
