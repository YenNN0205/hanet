import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get/get.dart';
import 'package:hanet/models/constants/menu_constants.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _controller = SideMenuController();

  int _currentIndex = 0;

  String tabName = "";

  @override
  Widget build(BuildContext context) {
    print(tabName);
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SideMenu(
              controller: _controller,
              backgroundColor: Colors.white,
              minWidth: 60,
              builder: (data) => SideMenuData(
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      height: 32,
                      width: 32,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF232B3E),
                      ),
                      onPressed: () {},
                      child: Text(
                        "+${data.isOpen ? "  Report" : ""}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    Text("Menu")
                  ],
                ),
                items: [
                  ...List.generate(
                    MenuOptions.length,
                    (index) {
                      print(index);
                      Map<String, Object> option = MenuOptions[index];
                      return SideMenuItemDataTile(
                        isSelected: index == _currentIndex,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            tabName = option['title'] as String;
                          });
                        },
                        title: option['title']! as String,
                        icon: Icon(option['icon']! as IconData),
                      );
                    },
                  )
                ],
                footer: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Profile"),
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    tabName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
