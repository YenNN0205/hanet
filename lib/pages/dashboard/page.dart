import 'package:flutter/material.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:hanet/pages/dashboard/sections/overview_section.dart';
import 'package:hanet/pages/dashboard/sections/schedule_section.dart';
import 'package:hanet/pages/dashboard/sections/traffic_status_section.dart';
import 'package:hanet/pages/dashboard/sections/traffic_table_section.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final sections = [
    TrafficTableSection(),
    // TrafficStatusSection(),
    OverviewSection(),
    // ScheduleSection(),
  ];
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            width: double.infinity,
            child: MediaQuery.of(context).size.width <= 500
                ? Column(
                    children: sections,
                  )
                : GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: sections,
                  )),
      ),
    );
  }
}
