import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/components/SearchButton.dart';
import 'package:hanet/controllers/person/person.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';
import 'package:hanet/models/constants/styles.c.dart';
import 'package:hanet/models/place/place.d.dart';

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

  RxInt selectedPlaceIndex = (-1).obs;
  late final List<HanetPlace> places;

  @override
  void initState() {
    super.initState();
    final personCtrl = Get.find<PersonController>();
    final placeCtrl = Get.find<PlaceController>();
    places = placeCtrl.places;

    if (places.isNotEmpty) {
      selectedPlaceIndex.value = 0;
      String placeID = places[selectedPlaceIndex.value].id.toString();
      // load old data
      employees.value = EmployeeDataSource.convertListPersonInPlace(
          personCtrl.peopleMap[placeID] ?? []);
      // refresh data background
      personCtrl.getPeopleByPlace(placeID).then((people) {
        employees.value = EmployeeDataSource.convertListPersonInPlace(people);
      });
    }
  }

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
                              child: DropdownButton<int>(
                                  hint: Text(
                                    "Place...",
                                    style: HanetTextStyles.buttonText
                                        .copyWith(color: Colors.grey),
                                  ),
                                  icon: Icon(Icons.arrow_drop_down),
                                  underline: const SizedBox(),
                                  value: selectedPlaceIndex.value >= 0
                                      ? selectedPlaceIndex.value
                                      : null,
                                  padding: EdgeInsets.zero,
                                  items: List.generate(
                                    places.length,
                                    (index) => DropdownMenuItem(
                                      value: index,
                                      child: Text(
                                        places[index].name ?? "",
                                        style: HanetTextStyles.buttonText
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    selectedPlaceIndex.value = val ?? -1;
                                  }),
                            ),
                          )
                        ]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Container(
                            constraints:
                                BoxConstraints(maxHeight: Get.size.height),
                            child: SfDataGrid(
                                source:
                                    EmployeeDataSource(employees: employees),
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
                                              style: HanetTextStyles
                                                  .columnTitle))),
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
                                              style: HanetTextStyles
                                                  .columnTitle))),
                                  GridColumn(
                                      columnName: "categorize",
                                      minimumWidth: 150,
                                      columnWidthMode: ColumnWidthMode.fill,
                                      allowSorting: true,
                                      label: Container(
                                          color: Colors.white,
                                          alignment: Alignment.centerLeft,
                                          child: Text("Categorize",
                                              style: HanetTextStyles
                                                  .columnTitle))),
                                  GridColumn(
                                      columnName: "department",
                                      columnWidthMode: ColumnWidthMode.fill,
                                      allowSorting: true,
                                      minimumWidth: 200,
                                      label: Container(
                                          color: Colors.white,
                                          alignment: Alignment.centerLeft,
                                          child: Text("Department",
                                              style: HanetTextStyles
                                                  .columnTitle))),
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
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
