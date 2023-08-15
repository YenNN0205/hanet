import 'package:flutter/material.dart';
import 'package:hanet/layout/app_layout.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final _controller = SideMenuController();

  // int _currentIndex = 0;

  // ignore: prefer_const_declarations
  static final CAMERA_URL =
      "rtsp://192.168.68.182:554/user:1cinnovation;pwd:1cinnovation123";

  String tabName = "";

  @override
  Widget build(BuildContext context) {
    print(tabName);
    return AppLayout(
      child: Container(
        child: Text("Dashboard Page"),
      ),
    );
  }
}
