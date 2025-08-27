import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '/constants/app_colors.dart';
import '/constants/app_images.dart';
import '/helper/ui_helper.dart';
import '/views/home_view.dart';
import '/extensions/app_extension.dart';
import '/providers/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    homeScreen();

    super.initState();
  }

  void homeScreen() {
    timer = Timer(
      const Duration(seconds: 3),
      () => context.pushReplaceScreen(HomeView()),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Color get selectedColor {
    var ser = context.watch<ThemeProvider>();
    var darkTheme = ser.themeMode == ThemeMode.dark;
    return darkTheme ? AppColors.white : AppColors.deeporange;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenResp;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Lottie.asset(
              repeat: false,
              frameRate: FrameRate(200),
              AppImages.logo,
              fit: BoxFit.contain,
              height: size.height - 40,
              width: size.width,
            ),
            Spacer(),
            UIHelper.text(
              'Built by M Hamza Khan',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: selectedColor,
            ),
            6.0.getSize,
          ],
        ),
      ),
    );
  }
}
