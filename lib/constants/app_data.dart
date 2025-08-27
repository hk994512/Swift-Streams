import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../providers/theme_provider.dart';
import '/constants/app_images.dart';
import '/extensions/app_extension.dart';
import 'package:url_launcher/url_launcher_string.dart';


import '../static/dialogues.dart';
import 'app_colors.dart';

class AppData {
  static Future<void> sendContactEmail() async {
    const subject = 'Support Request - TV Stream App';
    const body =
        'Hello TV Stream Team,\n\n[Describe your issue or question here.]\n\n';
    const email = 'hamzakhan00561@gmail.com'; // Replace with your email

    final uri =
        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    } else {
      throw 'Could not launch email.';
    }
  }

  static state(BuildContext context, Color color) =>
      context.read<ThemeProvider>().iconColor(color);
  static final dropDownItems = [
    {'lab': 'System', 'ico': Icons.android, 'color': Colors.lightGreen},
    {'lab': 'Dark', 'ico': Icons.dark_mode, 'color': Colors.teal},
    {'lab': 'Light', 'ico': Icons.light_mode, 'color': Colors.indigoAccent},
  ];
  static homeItems(BuildContext context) => [
    {
      'lab': 'All',
      'ico': AppImages.all,
      'co': AppData.state(context, Color(0xff50CB93)),
    },
    {
      'lab': 'Channels',
      'ico': AppImages.channels,
      'co': AppData.state(context, Color(0xffF6318C)),
    },
    {
      'lab': 'Sports',
      'ico': AppImages.sports,
      'co': AppData.state(context, Color(0xffEB5B00)),
    },
  ];
  static drawerItems(BuildContext context) => [
    {
      'lab': 'Home',
      'ico': AppImages.home,
      'onTap': () {
        context.popScreen();
        context.read<HomeProvider>().toggleItem(0);
      },
      'color': AppColors.home,
    },

   
    {
      'lab': 'Copyright',
      'ico': AppImages.copyright,
      'onTap': () {
        context.popScreen();
        MyAlerts.showAlert(context);
      },
      'color': AppColors.cyanAcc,
    },
    {
      'lab': 'Share App',
      'ico': AppImages.share,
      'onTap': () {
        context.popScreen();
        context.read<HomeProvider>().shareApp();
      },
      'color': AppColors.shareColor,
    },
    {
      'lab': 'Contact Us',
      'ico': AppImages.dev,
      'onTap': sendContactEmail,
      'color': AppColors.deeporange,
    },
  ];
}
