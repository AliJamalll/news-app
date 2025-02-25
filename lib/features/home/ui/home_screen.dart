// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:news_app_route/core/theme/app_colors.dart';
// import 'package:news_app_route/features/home/ui/taps.dart';
// import 'package:news_app_route/models/category_list_model.dart';
// import '../../../core/routing/page_route_name.dart';
// import '../../../core/theme/style.dart';
// import '../widgets/Custom_Card_Categories.dart';
//
// class HomeScreen extends StatefulWidget {
//    HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//    CategoryListModel? _selectedCategory;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         scrolledUnderElevation: 0.0,
//         elevation: 0,
//         //leading: IconButton(onPressed: () {}, icon: Icon(Icons.list)),
//         title: Text(
//           _selectedCategory == null ?"Home" : _selectedCategory!.catName,
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         actions: [IconButton(onPressed: () {
//           Navigator.pushNamed(context, Routes.search);
//         }, icon: Icon(Icons.search))],
//       ),
//       drawer: Drawer(
//         backgroundColor: AppColors.black,
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.2,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.white
//               ),
//               child: Center(
//                 child: Text("News App",
//                 style: TextStyles.font24BlackBold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: GestureDetector(
//                 onTap: (){
//                   gotoHome();
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.home_outlined,size: 32,color: AppColors.white,),
//                     SizedBox(width: 10,),
//                     Text("Go To Home",
//                     style: TextStyles.font20WhiteBold,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 24,),
//             Divider(
//               indent: 20,
//               endIndent: 20,
//               color: AppColors.white,
//             )
//           ],
//         ),
//       ),
//       body: _selectedCategory == null ? SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Good Morning\nHere is Some News For You",
//                 style: TextStyles.font24BlackMedium,
//               ),
//               SizedBox(height: 16.h,),
//               CustomCardCategories(
//                 onCategroyClicked: onCategoryClicked,
//               ),
//             ],
//           ),
//         ),
//       ) : NewsTaps(categoryListModel: _selectedCategory!,),
//     );
//   }
//
//   void onCategoryClicked(CategoryListModel category){
//     setState(() {
//       _selectedCategory = category;
//       print(_selectedCategory!.catId);
//     });
//   }
//
//   void gotoHome(){
//     setState(() {
//     _selectedCategory = null;
//     Navigator.pop(context);
//     });
//   }
// }
