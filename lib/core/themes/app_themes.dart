import 'package:flutter/material.dart';
import 'package:invoices_management_app/core/themes/app_colors.dart';

class AppThemes {
  // dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    shadowColor: AppColors.darkBackgroundColor,
  );

  // light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    shadowColor: AppColors.lightBackgroundColor,
  );
}
