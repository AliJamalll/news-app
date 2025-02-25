// import 'package:flutter/material.dart';
// import 'package:news_app_route/core/theme/app_colors.dart';
// import 'package:news_app_route/data/api/api_manager.dart';
// import 'package:news_app_route/models/articles_response.dart';
// import 'package:news_app_route/models/category_list_model.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class NewsTaps extends StatefulWidget {
//    NewsTaps({super.key,  this.categoryListModel,this.article});
// final Article? article;
//   final CategoryListModel? categoryListModel;
//   @override
//   State<NewsTaps> createState() => _NewsTapsState();
// }
//
// class _NewsTapsState extends State<NewsTaps> {
//   int _selectedTabIndex = 0;
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: ApiManager.getSources(catId: widget.categoryListModel!.catId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             );
//           }
//           else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 snapshot.error.toString(),
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//             );
//           }
//           else {
//             var sources = snapshot.data?.sources ?? [];
//             if (sources.isEmpty) {
//               return const Center(
//                 child: Text(
//                   "No sources available",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               );
//             }
//
//             return Column(
//               children: [
//                 DefaultTabController(
//                   length: snapshot.data?.sources.length ?? 0,
//                   child: TabBar(
//                       dividerHeight: 0,
//                       tabAlignment: TabAlignment.start,
//                       isScrollable: true,
//                       indicatorColor: AppColors.black,
//                       unselectedLabelStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w300,
//                           color: AppColors.black),
//                       labelStyle: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.black),
//                       tabs: snapshot.data!.sources
//                           .map((e) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           child: Text(
//                             e.name ,
//                           ),
//                         ),
//                       ))
//                           .toList(),
//                     onTap: (index) {
//                       setState(() {
//                         _selectedTabIndex = index;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: FutureBuilder(
//                     future: ApiManager.getArticles(sourceId: sources[_selectedTabIndex].id),
//                     builder: (context, articleSnapshot) {
//                       if (articleSnapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         );
//                       }
//                       else if (articleSnapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             articleSnapshot.error.toString(),
//                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                         );
//                       }
//                       else {
//                         var articles = articleSnapshot.data?.articles ?? [];
//                         if (articles.isEmpty) {
//                           return const Center(
//                             child: Text(
//                               "No articles available",
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           );
//                         }
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ListView.separated(
//                             itemBuilder: (context, index) {
//                               var articless = articles[index];
//                               return InkWell(
//                                 onTap: (){
//                                   _articlesDetailsButtonSheet(context, articless);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(vertical: 10),
//                                   height: 360,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: AppColors.black,
//                                       width: 3
//                                     )
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         width: 370,
//                                         height: 220,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(image: NetworkImage(articless.urlToImage!),fit: BoxFit.cover ),
//                                           borderRadius: BorderRadius.circular(20)
//                                         ),
//                                       ),
//                                       SizedBox(height: 10,),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             //crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 articless.title,
//                                                 style: const TextStyle(
//                                                     fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                                                 textAlign: TextAlign.start,
//                                                 maxLines: 2,
//                                               ),
//                                               SizedBox(height: 10,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Flexible(
//                                                     flex: 2,
//                                                     child: Text(
//                                                       articless.author ?? "Unknown Author",
//                                                       style: const TextStyle(
//                                                           fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey
//                                                       ),
//                                                       textAlign: TextAlign.start,
//                                                       overflow: TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                   Flexible(
//                                                     flex: 1,
//                                                     child: Text(
//                                                       formatDate(articless.publishedAt),
//                                                       style: TextStyle(
//                                                           fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey),
//                                                       textAlign: TextAlign.end,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) => const SizedBox(height: 10),
//                             itemCount: articles.length,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// void _articlesDetailsButtonSheet(BuildContext context, Article article) {
// showModalBottomSheet(
//   isDismissible: true,
//   backgroundColor: Colors.transparent,
//     context: context,
//     builder: (context) => Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           margin: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(16)
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: 370,
//                 height: 220,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: NetworkImage(article.urlToImage!),fit: BoxFit.cover ),
//                     borderRadius: BorderRadius.circular(20)
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     //crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         article.title,
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                         textAlign: TextAlign.start,
//                         maxLines: 2,
//                       ),
//                       SizedBox(height: 10,),
//                       FilledButton(
//                           onPressed: (){
//                             launchUrl(Uri.parse(article.url),mode: LaunchMode.inAppBrowserView);
//                           },
//                           style: FilledButton.styleFrom(
//                             backgroundColor: AppColors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)
//                             ),
//                             padding: EdgeInsets.all(16),
//                             textStyle: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold
//                             )
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("View Full Article"),
//                             ],
//                           )
//                       )
//                     ],
//                   ),
//                 ),
//
//               ),
//             ],
//           ),
//         ),
//       ],
//     )
// );
// }
//
// String formatDate(DateTime dateTime) {
//   return "${dateTime.day}/${dateTime.month}/${dateTime.year}"; // DD/MM/YYYY format
// }
//
