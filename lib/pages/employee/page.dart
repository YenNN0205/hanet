import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/person/person.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/models/constants/colors.c.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/employee/employee.d.dart';
import 'package:hanet/models/employee/employee_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({super.key});

  static const TextStyle columnTitle = TextStyle(
      color: Color(0xFF64748B), fontSize: 15, fontWeight: FontWeight.w600);

  final List<Employee> employees = [
    EmployeeBuilder.createAnEmployee(),
    EmployeeBuilder.createAnEmployee(),
    EmployeeBuilder.createAnEmployee(),
    EmployeeBuilder.createAnEmployee(),
    EmployeeBuilder.createAnEmployee(),
  ];

  final List<String> places = [
    "Ha Noi",
    "Da Nang",
    "Ho Chi Minh City",
  ];

  Rx<String?> selectedPlace = Rx(null);

  @override
  Widget build(BuildContext context) {
    final personCtrl = Get.find<PersonController>();
    personCtrl.getPeopleByPlace("18265");
    final employeeSource = EmployeeDataSource(employees: employees);
    return AppLayout(
      child: Container(
        color: HanetColors.contentBackground,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  // constraints: BoxConstraints(maxWidth: size.width - 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Employees',
                        style: HanetTextStyles.h1Text,
                      ),
                      Text(
                        "Security and safety solutions suitable for residential areas",
                        style: HanetTextStyles.h3Text,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: HanetColors.buttonColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_download_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          "Export .csv",
                          style: HanetTextStyles.buttonText,
                        )
                      ]),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchButton(),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white,
                        child: DropdownButton(
                            hint: Text(
                              "Place...",
                              style: HanetTextStyles.buttonText
                                  .copyWith(color: Colors.grey),
                            ),
                            icon: Icon(Icons.arrow_drop_down),
                            underline: const SizedBox(),
                            value: selectedPlace.value,
                            padding: EdgeInsets.zero,
                            items: places
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: HanetTextStyles.buttonText
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              selectedPlace.value = val;
                            }),
                      ),
                    )
                  ]),
            ),
            Row(
              children: [
                Expanded(
                  child: SfDataGrid(source: employeeSource, columns: [
                    GridColumn(
                        width: 80,
                        columnName: "profile",
                        label: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Text(
                              "Profile",
                              style: columnTitle,
                            ))),
                    GridColumn(
                        columnWidthMode: ColumnWidthMode.fill,
                        columnName: "name",
                        minimumWidth: 150,
                        allowSorting: true,
                        label: Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text("Name", style: columnTitle))),
                    GridColumn(
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        allowSorting: true,
                        minimumWidth: 100,
                        columnName: "postion",
                        label: Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: const Text("Postion", style: columnTitle))),
                    GridColumn(
                        columnName: "categorize",
                        minimumWidth: 150,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: true,
                        label: Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text("Categorize", style: columnTitle))),
                    GridColumn(
                        columnName: "department",
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: true,
                        minimumWidth: 200,
                        label: Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text("Department", style: columnTitle))),
                    GridColumn(
                      width: 100,
                      columnName: "actions",
                      label: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text("Actions", style: columnTitle),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
