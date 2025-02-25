import 'package:flutter/material.dart';
import 'package:news_app_route/data/api/api_manager.dart';
import 'package:news_app_route/models/articles_response.dart';
import 'package:news_app_route/presentaion/home/home_navigator.dart';
import '../../core/constants/app_assets.dart';
import '../../core/routing/page_route_name.dart';
import '../../models/category_list_model.dart';

class HomeViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  CategoryListModel? selectedCategory;
  CategoryListModel? categoryListModel;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners(); // ✅ Notify UI when state changes
  }

  HomeNavigator? navigator;

  List<Source> sources = [];
  List<Article> article = [];

  String? errorMessage = "";

  List<CategoryListModel> categoryList = [
    CategoryListModel(catId: "general", catName: "General", catImg: appAssets.general),
    CategoryListModel(catId: "business", catName: "Business", catImg: appAssets.bus),
    CategoryListModel(catId: "sport", catName: "Sport", catImg: appAssets.sport),
    CategoryListModel(catId: "tec", catName: "Technology", catImg: appAssets.tec),
    CategoryListModel(catId: "enter", catName: "Entertainment", catImg: appAssets.enter),
    CategoryListModel(catId: "health", catName: "Health", catImg: appAssets.health),
    CategoryListModel(catId: "science", catName: "Science", catImg: appAssets.science),
  ];

  /// Returns the app bar title dynamically
  String get appBarTitle => selectedCategory?.catName ?? "Home";

  /// Updates the selected category and UI
  void onCategoryChange(CategoryListModel category) {
    selectedIndex = 1;
    selectedCategory = category;
    notifyListeners();
  }

  /// Resets to home state
  void resetHome() {
    selectedIndex = 0;
    selectedCategory = null;
    notifyListeners();
  }

  void navigateToSearch() {
    navigator!.navigateToSearchScreen();
  }

  Future<void> getSources() async {
    try{
      print("object");
      var response = await ApiManager.getSources(catId: categoryListModel!.catId);
      sources = response.sources ?? [];
    }catch(e){
      errorMessage = e.toString();
    }finally{
      notifyListeners();
    }
  }
}
