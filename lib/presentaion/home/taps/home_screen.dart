import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_route/core/theme/app_colors.dart';
import 'package:news_app_route/features/home/ui/taps.dart';
import 'package:news_app_route/models/category_list_model.dart';
import 'package:news_app_route/presentaion/home/home_view_model.dart';
import 'package:news_app_route/presentaion/home/taps/taps.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/style.dart';
import '../../../features/home/widgets/Custom_Card_Categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          body: homeViewModel.selectedCategory == null
              ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning\nHere is Some News For You",
                    style: TextStyles.font24BlackMedium,
                  ),
                  SizedBox(height: 16.h),
                  CustomCardCategories(
                    onCategroyClicked: homeViewModel.onCategoryChange,
                  ),
                ],
              ),
            ),
          )
              : NewsTaps(viewModel: homeViewModel),
        );
      },
    );
  }
}
