import 'package:flutter/material.dart';

import '/providers/fav_provider.dart';
import '/providers/drawer_provider.dart';
import '/providers/home_provider.dart';
import '/themes/app_theme.dart';
import 'providers/player_pro.dart';
import 'startup/startup.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favPro = FavProvider();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  await favPro.loadFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider<FavProvider>.value(value: favPro),
        ChangeNotifierProvider(create: (context) => PlayerPro()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ser = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      darkTheme: ser.darkTheme,
      themeMode: ser.themeMode,
      home: SplashScreen(),
    );
  }
}
