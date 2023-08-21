import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/person/person.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';
import 'package:hanet/models/constants/styles.c.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/person/employee.d.dart';
import '../../models/person/employee_data_source.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  RxList<Employee> employees = <Employee>[].obs;

  final List<String> places = [
    "Ha Noi",
    "Da Nang",
    "Ho Chi Minh City",
  ];

  @override
  void initState() {
    super.initState();
    final personCtrl = Get.find<PersonController>();
    final placeCtrl = Get.find<PlaceController>();
    String placeID = placeCtrl.places[0].id.toString();
    employees.value = EmployeeDataSource.convertListPersonInPlace(
        personCtrl.peopleMap[placeID] ?? []);
    if (placeCtrl.places.isNotEmpty) {
      personCtrl.getPeopleByPlace(placeID).then((people) {
        employees.value = EmployeeDataSource.convertListPersonInPlace(people);
      });
    }
  }

  Rx<String?> selectedPlace = Rx(null);

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SingleChildScrollView(
          child: DataListLayout(
              title: "All Employees",
              description:
                  "Security and safety solutions suitable for residential areas",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        child: Obx(
                          () => SfDataGrid(
                              source: EmployeeDataSource(employees: employees),
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
                                        child: Text("Name",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnWidthMode:
                                        ColumnWidthMode.fitByCellValue,
                                    allowSorting: true,
                                    minimumWidth: 100,
                                    columnName: "postion",
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: const Text("Postion",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnName: "categorize",
                                    minimumWidth: 150,
                                    columnWidthMode: ColumnWidthMode.fill,
                                    allowSorting: true,
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: Text("Categorize",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                    columnName: "department",
                                    columnWidthMode: ColumnWidthMode.fill,
                                    allowSorting: true,
                                    minimumWidth: 200,
                                    label: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: Text("Department",
                                            style:
                                                HanetTextStyles.columnTitle))),
                                GridColumn(
                                  width: 100,
                                  columnName: "actions",
                                  label: Container(
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Text("Actions",
                                        style: HanetTextStyles.columnTitle),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
