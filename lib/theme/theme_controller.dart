import 'package:flutter/material.dart';
import 'package:rephool_test/theme/app_colors.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  bool isDarkMode = (ThemeMode.system == ThemeMode.dark);



  


  bool isDark(BuildContext context) {
    if (mode == ThemeMode.dark) {
      return true;
    }
    if (mode == ThemeMode.light) {
      return false;
    }
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  AppColors colorsOf(BuildContext context) {
    return isDark(context) ? AppColors.dark : AppColors.light;
  }

  void setDark(bool dark) {

    mode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
