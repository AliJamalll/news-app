import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_route/core/theme/app_colors.dart';
import 'package:news_app_route/data/api/api_manager.dart';
import 'package:news_app_route/features/home/ui/taps.dart';
import 'package:news_app_route/models/articles_response.dart';
import 'package:news_app_route/presentaion/home/home_view_model.dart';

import '../../../models/category_list_model.dart';
import '../../../presentaion/home/taps/taps.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, this.categoryListModel});

  final CategoryListModel? categoryListModel;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Article> articles = [];
  int maxResult = 0;
  int currentPage = 1;
  String errorMessage = ""; // ✅ Change to non-nullable String

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener((){
      if(scrollController.position.pixels == (scrollController.position.maxScrollExtent)){
        if(controller.text.isNotEmpty && (maxResult > articles.length)){
          _search();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            leadingWidth: 0,
            floating: true,
            toolbarHeight: 88,
            title: TextFormField(
              onFieldSubmitted: (value){
                currentPage = 1; // ✅ Fix assignment
                maxResult = 0;
                _search();
              },
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close)),
                hintText: "Search",
                hintStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.black)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.black)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.black)),
              ),
            ),
          ),

          if (articles.isEmpty && errorMessage.isEmpty)
            SliverToBoxAdapter(
                child: Lottie.asset(
                  "assets/images/Animation - 1739981914133.json",
                )),

          if (articles.isEmpty && errorMessage.isNotEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

          if (articles.isNotEmpty)
            SliverList.separated(
              itemBuilder: (context, index) {
                if(index == articles.length){
                  return Center(child: CircularProgressIndicator(color: AppColors.black,),);
                }else{
                  return NewsTaps(article: articles[index],viewModel:homeViewModel ,);
                }
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: articles.length < maxResult ? articles.length + 1 : articles.length,
            ),
        ],
      ),
    );
  }

  _search() async {
    errorMessage = "";
    setState(() {}); // ✅ Immediately clear previous errors before fetching

    try {
      var response = await ApiManager.searchArticles(
        searchQuery: controller.text,
        pageNumber: currentPage,
      );

      articles.addAll(response?.articles ?? []);
      maxResult = response?.totalResults.toInt() ?? 0;
      currentPage++;
    } catch (e) {
      errorMessage = e.toString(); // ✅ Corrected assignment
    }

    setState(() {}); // ✅ Refresh UI after fetching
  }
}
