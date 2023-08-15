import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/models/constants/menu.c.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hanet:1C",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        drawer: Drawer(
          child: Column(
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
              ...List.generate(
                MenuOptions.length,
                (index) {
                  print(index);
                  Map<String, Object> option = MenuOptions[index];
                  return ListTile(
                    // isSelected: index == _currentIndex,
                    onTap: () {
                      Get.toNamed(option['route'] as String);
                    },
                    title: Text(option['title']! as String),
                    leading: Icon(option['icon']! as IconData),
                  );
                },
              )
            ],
          ),
        ),
        body: child,
      ),
    );
  }
}
