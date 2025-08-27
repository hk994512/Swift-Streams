import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 0;
  bool isLoading = false;
  toggleItem(int currentIndex) {
    selectedIndex = currentIndex;
    notifyListeners();
  }

  Future<void> refreshChannels() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
    notifyListeners();
  }

  shareApp() async {
    final content =
        'Please share our app with your friends and family,check out my website  https://hamzakhan-web.web.app/';
    final script = await SharePlus.instance.share(ShareParams(text: content));
    return script;
  }
}
