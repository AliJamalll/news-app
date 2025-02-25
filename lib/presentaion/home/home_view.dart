import 'package:flutter/material.dart';
import 'package:news_app_route/presentaion/home/home_view_model.dart';
import 'package:news_app_route/presentaion/home/taps/home_screen.dart';
import 'package:news_app_route/presentaion/home/taps/taps.dart';
import 'package:provider/provider.dart';
import '../../core/routing/page_route_name.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/style.dart';
import 'home_navigator.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeNavigator {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.navigator = this;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeViewModel.navigator = null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeView, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            scrolledUnderElevation: 0.0,
            elevation: 0,
            title: Text(
              homeView.appBarTitle,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: homeViewModel.navigateToSearch, // ✅ Corrected function call
                icon: const Icon(Icons.search),
              )
            ],
          ),
          drawer: Drawer(
            backgroundColor: AppColors.black,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Center(
                    child: Text(
                      "News App",
                      style: TextStyles.font24BlackBold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      homeView.resetHome(); // ✅ Corrected function call
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.home_outlined, size: 32, color: AppColors.white),
                        const SizedBox(width: 10),
                        Text(
                          "Go To Home",
                          style: TextStyles.font20WhiteBold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.white,
                )
              ],
            ),
          ),
          body: homeView.selectedIndex == 1 && homeView.selectedCategory != null
              ? NewsTaps(viewModel: homeView)
              : HomeScreen(),

        ),
      ),
    );
  }

  @override
  void navigateToSearchScreen() {
    // TODO: implement navigateToSearchScreen
    Navigator.pushNamed(context, Routes.search);

  }
}
