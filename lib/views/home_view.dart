import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/app_data.dart';
import '/views/all.dart';
import '/helper/ui_helper.dart';
import '../providers/home_provider.dart';
import 'sports.dart';
import '/views/channels_interface.dart';

List<Widget> screens = [All(), Channels(), Sports()];

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ser = context.watch<HomeProvider>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: ser.toggleItem,
        currentIndex: ser.selectedIndex,
        items: [
          for (var s in AppData.homeItems(context))
            BottomNavigationBarItem(
              tooltip: s['lab'] as String,
              icon: UIHelper.image(
                s['ico'] as String,
                fit: BoxFit.cover,
                height: 35,
                color: s['co'] as Color,
              ),
              label: s['lab'] as String,
            ),
        ],
      ),

      body: IndexedStack(index: ser.selectedIndex, children: screens),
    );
  }
}
