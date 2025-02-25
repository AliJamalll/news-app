import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_route/core/theme/app_colors.dart';

import 'font_wieght_helper.dart';

class TextStyles{

  static TextStyle font16Black700weight = TextStyle(
      fontWeight: FontWeightHelper.bold,
      fontSize: 16.sp,
      color: Colors.black
  );

  static TextStyle font12GrayMedium = TextStyle(
      fontWeight: FontWeightHelper.medium,
      fontSize: 12.sp,
      color: AppColors.black
  );

  static TextStyle font14WhiteMedium = TextStyle(
      fontWeight: FontWeightHelper.regular,
      fontSize: 14.sp,
      color: AppColors.white
  );

  static TextStyle font20WhiteBold = TextStyle(
      fontWeight: FontWeightHelper.bold,
      fontSize: 20.sp,
      color: AppColors.white
  );

  static TextStyle font24BlackMedium = TextStyle(
      fontWeight: FontWeightHelper.medium,
      fontSize: 24.sp,
      color: AppColors.black
  );
  static TextStyle font24BlackBold = TextStyle(
      fontWeight: FontWeightHelper.bold,
      fontSize: 24.sp,
      color: AppColors.black
  );

}