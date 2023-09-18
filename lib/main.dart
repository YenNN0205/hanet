import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hanet/controllers/controller.dart';
import 'package:hanet/models/constants/route.c.dart';
import 'package:hanet/scroll_behavior.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  //load env data
  await dotenv.load(fileName: 'env');
  // init all instance of controller
  RootController.initControllers();
  // init data before run
  await RootController.initData();
  print("Done init data");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'TechFis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: routePages,
      initialRoute: Routes.DASHBOARD,
    );
  }
}
