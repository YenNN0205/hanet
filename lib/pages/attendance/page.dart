import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hanet/controllers/attendance/attendance.ctrl.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/layout/data_list_layout.dart';
import 'package:hanet/pages/attendance/overview_checkin_table.dart';
import 'package:hanet/pages/attendance/today_checkin_table.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../components/PlaceDropDown.dart';
import '../../components/SearchButton.dart';
import '../../controllers/place/place.ctrl.dart';
import '../../models/attendance/checkin.d.dart';
import '../../models/place/place.d.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  final PlaceController placeCtrl = Get.find<PlaceController>();
  final attendanceCtrl = Get.find<AttendanceController>();

  RxInt selectedPlaceIndex = (-1).obs;
  RxInt selectedTabIndex = 0.obs;
  late Rx<DateTime> pickedMonth;
  late List<HanetPlace> places;
  late final TabController _tabController;

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
    pickedMonth = DateTime.now().obs;
    places = placeCtrl.places;
    if (places.isNotEmpty) {
      selectedPlaceIndex.value = 0;
    }
  }

  onDatePickedTap() async {
    final pickedVal = await showMonthYearPicker(
        context: context,
        initialDate: pickedMonth.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(const Duration(days: 365 * 50)));
    if (pickedVal != null) {
      pickedMonth.value = pickedVal;
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
                Obx(() => selectedTabIndex.value == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black87, width: 0.5),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: -12,
                                    blurRadius: 8,
                                  )
                                ]),
                            child:
                                Row(mainAxisSize: MainAxisSize.max, children: [
                              IconButton(
                                onPressed: () {
                                  var currentPicked = pickedMonth.value;
                                  currentPicked = currentPicked
                                      .subtract(const Duration(days: 28));
                                  pickedMonth.value = DateUtils.dateOnly(
                                      DateTime(currentPicked.year,
                                          currentPicked.month, 1));
                                },
                                icon: const Icon(
                                  Icons.chevron_left,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: onDatePickedTap,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      decoration: const BoxDecoration(
                                          border: Border.symmetric(
                                              vertical: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black87))),
                                      alignment: Alignment.center,
                                      child: Text(DateFormat("MMMM y")
                                          .format(pickedMonth.value)),
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  var currentPicked = pickedMonth.value;
                                  currentPicked = currentPicked
                                      .add(const Duration(days: 31));
                                  pickedMonth.value = DateUtils.dateOnly(
                                      DateTime(currentPicked.year,
                                          currentPicked.month, 1));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      )
                    : const SizedBox()),
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
                            pickedMonth: pickedMonth.value,
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
