// ignore: avoid_web_libraries_in_flutter

// Fake interface for the logic that this package needs from (web-only) dart:ui.
// This is conditionally exported so the analyzer sees these methods as available.

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: camel_case_types

class platformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {}
}

/// Shim for web_ui engine.AssetManager.
/// https://github.com/flutter/engine/blob/main/lib/web_ui/lib/src/engine/assets.dart#L12
class webOnlyAssetManager {
  /// Shim for getAssetUrl.
  /// https://github.com/flutter/engine/blob/main/lib/web_ui/lib/src/engine/assets.dart#L45
  static String getAssetUrl(String asset) => '';
}

/// Signature of callbacks that have no arguments and return no data.
typedef VoidCallback = void Function();
