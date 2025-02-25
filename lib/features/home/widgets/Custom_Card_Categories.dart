import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_route/core/theme/app_colors.dart';
import 'package:news_app_route/core/theme/style.dart';
import 'package:news_app_route/presentaion/home/home_view_model.dart';

import '../../../core/constants/app_assets.dart';
import '../../../models/category_list_model.dart';

class CustomCardCategories extends StatelessWidget {
  final void Function(CategoryListModel) onCategroyClicked;
   CustomCardCategories({super.key,required this.onCategroyClicked,});

   HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Stack(
            alignment: (index % 2 == 0) ?Alignment.bottomRight : Alignment.bottomLeft,
            children: [
              Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(image: AssetImage(homeViewModel.categoryList[index].catImg),fit: BoxFit.cover)
                ),
              ),
              GestureDetector(
                onTap: (){
                  onCategroyClicked(homeViewModel.categoryList[index]);
                },
                child: Container(
                  height:55.h,
                  width: 170.w,
                  margin: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(84)
                  ),
                  child: Directionality(
                    textDirection:  (index % 2 == 0) ? TextDirection.ltr : TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                          child: Text("View All",
                          style: TextStyles.font24BlackMedium,
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white
                          ),
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
        separatorBuilder: (context,index) => SizedBox(height: 16.h,),
        itemCount: homeViewModel.categoryList.length,
      ),
    );
  }

}
