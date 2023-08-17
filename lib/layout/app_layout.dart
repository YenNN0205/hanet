import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/menu.ctrl.dart';
import 'package:hanet/models/constants/menu.c.dart';
import 'package:hanet/resources/images/image.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final menuCtrl = Get.find<MenuItemController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hanet:1C",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  GestureDetector(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Color(0xFF232B3E)),
                        child: Text(
                          "+ Report",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {},
                  ),
                  ...List.generate(
                    MenuOptions.length,
                    (index) {
                      Map<String, Object> option = MenuOptions[index];
                      return Obx(
                        () => ListTile(
                          // isSelected: index == _currentIndex,
                          onTap: () {
                            menuCtrl.selectedMenuIndex.value = index;
                            Get.toNamed(option['route'] as String);
                          },
                          title: Text(option['title']! as String),
                          leading: Icon(option['icon']! as IconData),
                          selected: index == menuCtrl.selectedMenuIndex.value,
                        ),
                      );
                    },
                  )
                ],
              ),
              const Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  Text("Profile"),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(AssetImages.avatar),
                  )
                ],
              )
            ],
          ),
        ),
        body: child,
      ),
    );
  }
}
