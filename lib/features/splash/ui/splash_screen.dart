import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_route/core/constants/app_assets.dart';
import 'package:news_app_route/core/routing/page_route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushNamed(context, Routes.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250.h,
          ),
          Image.asset(appAssets.splashMic),
          Spacer(),
          Image.asset(appAssets.splashLogo,height: 85,width: 214,),

        ],
      ),
    );
  }
}
