import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/extensions/app_extension.dart';
import '/constants/app_colors.dart';
import '/model/Channel.dart';

class FavProvider extends ChangeNotifier {
  List<Channel> favsItems = [];
  String script = '';
  String title = '';
  favChannel(Channel channel, BuildContext context) {
    final contain = favsItems.any((ch) => ch.title == channel.title);
    script =
        contain
            ? '${channel.title} added to favorites'
            : '${channel.title} removed from favorites';
    title = !contain ? 'Removed Favorite' : 'Added Favorite';
    context.showAlert(context, title, script);
    return script;
  }

  IconData icon = Icons.favorite_border;
  Color favColor = AppColors.white;

  /// Toggle favorites
  toggleFavs(Channel channel) {
    final exists = favsItems.any((c) => c.title == channel.title);
    if (exists) {
      favsItems.removeWhere((c) => c.title == channel.title);
      icon = Icons.favorite_border;
      favColor = AppColors.white;
    } else {
      favsItems.add(channel);
      icon = Icons.favorite;
      favColor = AppColors.red;
    }

    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favListJson = favsItems.map((c) => c.toJson()).toList();
    await prefs.setString('favorites', jsonEncode(favListJson));
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('favorites');

    if (stored != null) {
      final decoded = jsonDecode(stored) as List;
      favsItems = decoded.map((e) => Channel.fromJson(e)).toList();
    }

    notifyListeners();
  }
}
