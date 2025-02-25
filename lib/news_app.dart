import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_route.dart';
import 'core/routing/page_route_name.dart';
import 'core/theme/app_theme_manager.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: appThemeManager.lightThemeData,
        darkTheme: appThemeManager.darkThemeData,
        //themeMode: provider.currentThemeMode,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}