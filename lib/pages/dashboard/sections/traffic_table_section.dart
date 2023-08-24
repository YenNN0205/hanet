import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/controllers/place/place.ctrl.dart';
import 'package:hanet/models/attendance/checkin.d.dart';
import 'package:hanet/models/attendance/traffic_data_source.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/constants/styles.c.dart';

class TrafficTableSection extends StatelessWidget {
  TrafficTableSection({super.key});

  RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  final PlaceController _placeController = Get.find<PlaceController>();
  final AttendanceController _attController = Get.find<AttendanceController>();
  RxBool isLoading = true.obs;
  void getTodayTraffic() {
    if (_placeController.places.isNotEmpty) {
      isLoading.value = true;
      String placeID = _placeController.places[0].id.toString();
      _attController
          .getCheckInToday(
              placeID: placeID,
              date: DateFormat("yyyy-MM-dd").format(DateTime.now()))
          .then((checkInList) {
        checkIns.clear();
        checkIns.addAll(checkInList);
        isLoading.value = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getTodayTraffic();
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's traffic"),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Obx(
                  () => SfDataGrid(
                      source: TrafficDataSource(checkIns: checkIns),
                      columns: [
                        GridColumn(
                          width: 200,
                          columnName: "id",
                          label: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Text(
                              "ID",
                              style: HanetTextStyles.columnTitle,
                            ),
                          ),
                        ),
                        GridColumn(
                            columnName: "picture",
                            width: 100,
                            allowSorting: true,
                            label: Container(
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: Text("Picture",
                                    style: HanetTextStyles.columnTitle))),
                        GridColumn(
                            allowSorting: true,
                            minimumWidth: 100,
                            columnWidthMode: ColumnWidthMode.fill,
                            columnName: "name",
                            label: Container(
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text("Name",
                                    style: HanetTextStyles.columnTitle))),
                        GridColumn(
                            columnName: "check_in",
                            columnWidthMode: ColumnWidthMode.fill,
                            minimumWidth: 150,
                            allowSorting: true,
                            label: Container(
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: Text("Check-in time",
                                    style: HanetTextStyles.columnTitle))),
                        GridColumn(
                            columnName: "classification",
                            allowSorting: true,
                            minimumWidth: 100,
                            label: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text("Classification",
                                    style: HanetTextStyles.columnTitle))),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
