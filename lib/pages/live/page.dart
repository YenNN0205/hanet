import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

import 'package:hanet/layout/app_layout.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

String CAMERA_URL =
    "rtsp://0.tcp.ap.ngrok.io:13067/user:1cinnovation;pwd:1cinnovation123";

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VlcPlayerController? _videoPlayerController;

  late final WebViewPlusController _webViewController;
  late final WebViewController webViewController;
  PlatformWebViewController? _controller;
  bool isSupport = true;
  @override
  void initState() {
    super.initState();
    isSupport = isSupportPlatform();
    if (kIsWeb) {
      _controller = PlatformWebViewController(
        const PlatformWebViewControllerCreationParams(),
      );
      rootBundle.loadString("assets/camera/index.html").then((html) {
        _controller!.loadRequest(LoadRequestParams(
            uri: UriData.fromString(html,
                    mimeType: "text/html",
                    encoding: Encoding.getByName("utf-8"))
                .uri));
        setState(() {});
      });
    }
  }

// support android, ios, web not for desktop
  bool isSupportPlatform() {
    bool isNotSupported = true;
    try {
      print(defaultTargetPlatform);
      if (Platform.isAndroid || Platform.isIOS) {
        isNotSupported = false;
      }
    } catch (e) {
      print("Exception detect platform");
    }
    return kIsWeb && !isNotSupported;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    Size size = Get.size;
    if (isSupport) {
      // if (kIsWeb) {
      //   // _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      //   // _controller.loadRequest(
      //   //   LoadRequestParams(
      //   //     uri: Uri.file('assets/camera/index.html'),
      //   //   ),
      //   // );
      //   child = PlatformWebViewWidget(
      //           PlatformWebViewWidgetCreationParams(controller: _controller!))
      //       .build(context);
      // } else {
      child = WebViewPlus(
        initialUrl: "assets/camera/index.html",
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        allowsInlineMediaPlayback: true,
      );
      // }
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
        height: 600,
        color: Colors.black,
        child: child,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
