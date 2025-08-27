import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/constants/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _selectedTheme = 'System';

  ThemeProvider() {
    loadTheme();
  }

  // Getters
  ThemeMode get themeMode => _themeMode;
  String get selectedTheme => _selectedTheme;
  Color iconColor(Color color) =>
      selectedTheme.contains('Dark')
          ? Colors.white
          : selectedTheme.contains('System')
          ? color
          : color;

  /// Set theme mode and save to preferences
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    await _saveTheme(mode);
    notifyListeners();
  }

  /// Save theme preference
  Future<void> _saveTheme(ThemeMode themeMode) async {
    _selectedTheme = _getThemeName(themeMode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTheme', themeMode.toString());
  }

  /// Load saved theme preference
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final modeString = prefs.getString('selectedTheme');

    if (modeString != null) {
      _themeMode = _parseThemeMode(modeString);
      _selectedTheme = _getThemeName(_themeMode);
    }
    notifyListeners();
  }

  /// Helper to parse ThemeMode from string
  ThemeMode _parseThemeMode(String modeString) {
    switch (modeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Helper to get theme name
  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  /// Common text theme configuration
  TextTheme _getTextTheme(Color primaryColor) {
    return TextTheme(
      titleLarge: GoogleFonts.mooli(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.mooli(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: primaryColor.withOpacity(0.87),
      ),
      titleSmall: GoogleFonts.mooli(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: primaryColor.withOpacity(0.6),
      ),
    );
  }

  /// Common app bar theme configuration
  AppBarTheme _getAppBarTheme(Color backgroundColor, Color foregroundColor) {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: foregroundColor),
      titleTextStyle: GoogleFonts.mooli(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: foregroundColor,
      ),
      foregroundColor: foregroundColor,
    );
  }

  /// Common bottom navigation bar theme
  BottomNavigationBarThemeData _getBottomNavTheme(
    Color backgroundColor,
    Color selectedColor,
    Color unselectedColor,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      elevation: 5,
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: selectedColor,
      ),
      unselectedLabelStyle: GoogleFonts.mooli(
        fontSize: 14,
        color: unselectedColor,
      ),
    );
  }

  /// Dark theme configuration
  ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
    textTheme: _getTextTheme(AppColors.white),
    scaffoldBackgroundColor: AppColors.black,
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
    ),
    appBarTheme: _getAppBarTheme(AppColors.black, AppColors.white),
    bottomNavigationBarTheme: _getBottomNavTheme(
      AppColors.black,
      AppColors.white,
      AppColors.white70,
    ),
  );

  /// Light theme configuration
  ThemeData get lightTheme => ThemeData.light(useMaterial3: true).copyWith(
    textTheme: _getTextTheme(AppColors.black),
    scaffoldBackgroundColor: AppColors.white,
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
    ),
    appBarTheme: _getAppBarTheme(AppColors.white, AppColors.black),
    bottomNavigationBarTheme: _getBottomNavTheme(
      AppColors.white,
      AppColors.black,
      AppColors.black,
    ),
  );
}
