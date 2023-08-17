// import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CameraPlayer extends StatefulWidget {
  final String rstpUrl;
  const CameraPlayer({required this.rstpUrl, super.key});

  @override
  State<CameraPlayer> createState() => _CameraPlayerState();
}

class _CameraPlayerState extends State<CameraPlayer> {
  late final VlcPlayerController _controller;
  late bool isWebRunning = false;

  // late final Player _dartPLayer;

  @override
  void initState() {
    super.initState();
    // check if running on web and initial DartVLC player
    if (kIsWeb) {
      isWebRunning = true;
      // _dartPLayer = Player(id: 69420);
      // _dartPLayer.open(Media.network(widget.rstpUrl), autoStart: true);
    }
    //running on mobile device (Android, iOs)
    else {
      _controller = VlcPlayerController.network(
        widget.rstpUrl,
        autoPlay: true,
        // autoInitialize: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: VlcPlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
        placeholder: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
