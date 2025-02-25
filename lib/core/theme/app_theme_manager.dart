import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class appThemeManager{
  static ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.white
  );

  static ThemeData darkThemeData = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
  );

}