import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get/get.dart';
import 'package:hanet/pages/page.dart';
import 'package:hanet/models/constants/menu_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = SideMenuController();

  int _currentIndex = 0;

  String tabName = "";
  
  List<Widget> widgetOptions = [
    DashBoardPage(),
    AllEmployeesPage(),
    Container(color: Colors.blue),
    Container(color: Colors.purple),
    Container(color: Colors.green),
    Container(color: Colors.amber),
    Container(color: Colors.teal),
  ];

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
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                   SizedBox(height: 20,)
                  ],
                ),
                items: [
                  ...List.generate(
                    menuOptions.length,
                    (index) {
                      print(index);
                      Map<String, Object> option = menuOptions[index];
                      return SideMenuItemDataTile(
                        highlightSelectedColor: Colors.green,
                        hoverColor: Colors.grey,
                        hasSelectedLine: false,
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
                      const Text("Profile", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                      Container(
                       margin: EdgeInsets.only(bottom: 24,top: 8),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                ),
              ),
            ),
            Expanded(
              child: widgetOptions.elementAt(_currentIndex),
            ),
          ],
        ),
      ),
    );
  }
}