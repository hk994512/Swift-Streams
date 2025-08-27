import 'dart:io' show Platform;
import 'package:android_intent_plus/android_intent.dart';
import 'package:appcheck/appcheck.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayerPro extends ChangeNotifier {
  final String _packageName = "com.urdutech.miniplayer";
  final String _playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.urdutech.miniplayer";

  Future<void> openMiniPlayer({required String stream}) async {
    try {
      // Validate URL
      if (!Uri.parse(stream).isAbsolute) {
        throw Exception("Invalid stream URL");
      }

      final isInstalled = await _isAppInstalled();
      if (isInstalled) {
        await _launchPlayer(stream);
      } else {
        await _openPlayStore();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error opening player: $e");
      }
    
      if (await canLaunchUrl(Uri.parse(stream))) {
        await launchUrl(
          Uri.parse(stream),
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  Future<bool> _isAppInstalled() async {
    try {
      final app = await AppCheck().checkAvailability(_packageName);
      return app != null && app.packageName == _packageName;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error checking app: $e");
      }
      return false;
    }
  }

  Future<void> _launchPlayer(String stream) async {
    try {
      if (Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(stream),
          type: 'video/*',
          package: _packageName,
        );
        await intent.launch();
      } else {
        // Fallback for non-Android platforms
        if (await canLaunchUrl(Uri.parse(stream))) {
          await launchUrl(
            Uri.parse(stream),
            mode: LaunchMode.externalApplication,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error launching player: $e");
      }
      rethrow;
    }
  }

  Future<void> _openPlayStore() async {
    try {
      if (await canLaunchUrl(Uri.parse(_playStoreUrl))) {
        await launchUrl(
          Uri.parse(_playStoreUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback: Open web version
        await launchUrl(
          Uri.parse(_playStoreUrl),
          mode: LaunchMode.platformDefault,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error opening Play Store: $e");
      }
    }
  }
}
