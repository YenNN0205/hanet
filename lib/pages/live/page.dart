import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:hanet/layout/app_layout.dart';

String CAMERA_URL =
    "rtsp://192.168.68.182:554/user:1cinnovation;pwd:1cinnovation123";

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VlcPlayerController? _videoPlayerController;
  bool kisweb = true;
  @override
  void initState() {
    super.initState();

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        kisweb = false;
        _videoPlayerController = VlcPlayerController.network(
          CAMERA_URL,
          autoPlay: true,
          hwAcc: HwAcc.auto,
          options: VlcPlayerOptions(),
        );
      } else {
        kisweb = true;
      }
    } catch (e) {
      kisweb = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    Size size = Get.size;
    if (!kisweb) {
      child = VlcPlayer(
        controller: _videoPlayerController!,
        aspectRatio: 16 / 9,
      );
    } else {
      child = const Center(
        child: Text(
          "Not support on this operating system!",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      );
    }

    return AppLayout(
        child: Center(
      child: Container(
        width: size.width,
        height: size.width / 16 * 9,
        color: Colors.black,
        child: child,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoPlayerController != null) {
      _videoPlayerController!.stopRendererScanning();
      _videoPlayerController!.dispose();
    }
  }
}
