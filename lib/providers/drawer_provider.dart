import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  String selected = 'System';
  chosenMenu(String currentItem) {
    selected = currentItem;
    notifyListeners();
  }
}
