import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';

import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../components/PlaceDropDown.dart';
import '../../components/SearchButton.dart';
import '../../controllers/place/place.ctrl.dart';
import '../../models/attendance/checkin.d.dart';
import '../../models/place/place.d.dart';
import 'tabs/overview_checkin_table.dart';
import 'tabs/today_checkin_table.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  final PlaceController placeCtrl = Get.find<PlaceController>();

  RxInt selectedPlaceIndex = (-1).obs;
  RxInt selectedTabIndex = 0.obs;

  late final TabController _tabController;
  late List<HanetPlace> places;

  static const List<Tab> tabs = [
    Tab(
      text: "Today",
    ),
    Tab(
      text: "Overview",
    ),
  ];
  RxList<HanetCheckIn> checkIns = <HanetCheckIn>[].obs;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    places = placeCtrl.places;
    if (places.isNotEmpty) {
      selectedPlaceIndex.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SingleChildScrollView(
        child: DataListLayout(
            title: "Attendance",
            description:
                "Security and safety solutions suitable for residential areas",
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  onTap: (tabIndex) {
                    selectedTabIndex.value = tabIndex;
                  },
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: tabs,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchButton(),
                        Row(
                          children: [
                            Obx(
                              () => PlaceDropdown(
                                selectedPlaceIndex: selectedPlaceIndex.value,
                                places: places,
                                onChanged: (val) {
                                  selectedPlaceIndex.value = val ?? -1;
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: Get.size.height),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Obx(
                        () => TodayCheckInTable(
                          placeID: (selectedPlaceIndex.value >= 0)
                              ? places[selectedPlaceIndex.value].id.toString()
                              : "",
                        ),
                      ),
                      Obx(
                        () => OverviewCheckInTable(
                            // pickedMonth: pickedMonth.value,
                            placeID: (selectedPlaceIndex.value >= 0)
                                ? places[selectedPlaceIndex.value].id.toString()
                                : ""),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
