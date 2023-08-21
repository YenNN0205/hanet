import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanet/models/constants/route.c.dart';

class SplashBuilder extends StatefulWidget {
  final Function? onInitFunction;
  final Widget splash;
  final Widget child;

  const SplashBuilder({
    required this.child,
    required this.splash,
    this.onInitFunction,
    super.key,
  });

  @override
  State<SplashBuilder> createState() => _SplashBuilderState();
}

class _SplashBuilderState extends State<SplashBuilder> {
  Future<String> _asyncProgress() async {
    if (widget.onInitFunction != null) {
      await widget.onInitFunction!();
      print("Done process data");
      Get.toNamed(Routes.DASHBOARD);
    }
    return "Done";
  }

  @override
  void initState() {
    super.initState();
    _asyncProgress();
  }

  @override
  Widget build(BuildContext context) {
    return widget.splash;
  }
}
