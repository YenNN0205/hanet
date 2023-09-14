import 'package:hanet/controllers/utils/dart_ui/dart_ui.dart';
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:hanet/controllers/utils/utils.dart';
import 'package:hanet/layout/app_layout.dart';
import 'package:universal_html/html.dart' as universal_html;
import 'package:webview_flutter/webview_flutter.dart';

String CAMERA_URL =
    "rtsp://0.tcp.ap.ngrok.io:13067/user:1cinnovation;pwd:1cinnovation123";

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VlcPlayerController? _videoPlayerController;

  late final WebViewController _webViewController;

  bool isSupport = true;
  @override
  void initState() {
    super.initState();
    isSupport = isSupportPlatform();
    if (kIsWeb) {
      platformViewRegistry.registerViewFactory("camera_view", (id) {
        var _iframeElement = universal_html.IFrameElement();
        _iframeElement.height = '500';
        _iframeElement.allow = "microphone";
        _iframeElement.src = "https://vinhpna1c.github.io/ezviz-camera-live/";

        return _iframeElement;
      });
      // _controller = PlatformWebViewController(
      //   const PlatformWebViewControllerCreationParams(),
      // );
      // rootBundle.loadString("assets/camera/index.html").then((html) {
      //   _controller!.loadRequest(LoadRequestParams(
      //       uri: UriData.fromString(html,
      //               mimeType: "text/html",
      //               encoding: Encoding.getByName("utf-8"))
      //           .uri));
      //   setState(() {});
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    Size size = Get.size;
    if (isSupport) {
      if (kIsWeb) {
        child = HtmlElementView(key: UniqueKey(), viewType: "camera_view");
      } else {
        _webViewController = WebViewController(
          onPermissionRequest: (request) {
            print("Request from webview");
          },
        );
        _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
        _webViewController.setNavigationDelegate(NavigationDelegate());
        _webViewController.loadRequest(
            Uri.parse("https://vinhpna1c.github.io/ezviz-camera-live/"));
        child = WebViewWidget(
          controller: _webViewController,
        );
      }
    } else {
      child = Center(
        child: const Text(
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
        color: isSupport ? Colors.white : Colors.black,
        child: child,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
