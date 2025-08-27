import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/extensions/app_extension.dart';
import '/constants/app_data.dart';
import '/constants/app_colors.dart';
import '/constants/app_images.dart';
import '/providers/drawer_provider.dart';
import '/providers/theme_provider.dart';
import '../helper/ui_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ser = context.watch<ThemeProvider>();
    final drawerPro = context.watch<DrawerProvider>();
    String selected = 'System';

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cyanAcc, AppColors.deepPurple],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UIHelper.text(
                  'Swift Stream',
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03,
                  color: AppColors.deeporange,
                ),
                UIHelper.image(
                  AppImages.all,
                  fit: BoxFit.fill,
                  height: size.height * 0.12,
                  width: size.width,
                  color: AppColors.deeporange,
                ),
              ],
            ),
          ),

          for (var selected in AppData.drawerItems(context))
            ListTile(
              leading: UIHelper.image(
                selected['ico'] as String,
                height: size.height * 0.040,
                color: selected['color'] as Color,
              ),
              title: UIHelper.text(
                selected['lab'] as String,
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w700,
              ),
              onTap: selected['onTap'] as VoidCallback,
            ),
          PopupMenuDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.height * 0.01),
                child: Icon(
                  ser.selectedTheme == 'Dark'
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color:
                      ser.selectedTheme != 'Dark'
                          ? AppColors.appColor
                          : Colors.lightGreenAccent,
                  size: size.height * 0.032,
                ),
              ),
              UIHelper.text(
                'Theme',
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w700,
              ),
              5.0.getWidth,
              DropdownButton(
                isDense: true,
                value: ser.selectedTheme,
                items:
                    AppData.dropDownItems
                        .map(
                          (s) => DropdownMenuItem(
                            value: s['lab'] as String,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                UIHelper.text(
                                  s['lab'] as String,
                                  fontSize: size.height * 0.017,
                                  fontWeight: FontWeight.w500,
                                ),
                                Icon(
                                  s['ico'] as IconData,
                                  color: s['color'] as Color,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  selected = value as String;
                  drawerPro.chosenMenu(selected);
                  ser.setThemeMode(
                    selected == 'System'
                        ? ThemeMode.system
                        : selected == 'Dark'
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                },
              ),
            ],
          ),

          ListTile(
            subtitle: UIHelper.text('1.0_0'),
            leading: UIHelper.image(
              AppImages.settings,
              color: AppColors.deepPurple,
              height: size.height * 0.040,
            ),
            title: UIHelper.text(
              'Version',
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w700,
            ),
          ),

          ListTile(
            onTap: () => SystemNavigator.pop(),
            leading: UIHelper.image(
              AppImages.exit,
              color: AppColors.redAcc,
              height: size.height * 0.040,
            ),
            title: UIHelper.text(
              'Exit',
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
