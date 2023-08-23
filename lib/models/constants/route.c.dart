// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:hanet/pages/attendance/page.dart';
import 'package:hanet/pages/dashboard/page.dart';
import 'package:hanet/pages/department/page.dart';
import 'package:hanet/pages/employee/page.dart';
import 'package:hanet/pages/live/page.dart';
import 'package:hanet/pages/place/page.dart';

class Routes {
  static String DASHBOARD = "/dashboard";
  static String LIVE = "/live";
  static String EMPLOYEE = "/employee";
  static String PLACE = "/place";
  static String DEPARTMENT = "/department";
  static String ATTENDANCE = "/attendance";
}

final routePages = [
  GetPage(name: Routes.DASHBOARD, page: () => DashboardScreen()),
  GetPage(name: Routes.LIVE, page: () => LiveScreen()),
  GetPage(name: Routes.EMPLOYEE, page: () => EmployeeScreen()),
  GetPage(name: Routes.PLACE, page: () => PlaceScreen()),
  GetPage(name: Routes.DEPARTMENT, page: () => DepartmentScreen()),
  GetPage(name: Routes.ATTENDANCE, page: () => AttendanceScreen()),
];
