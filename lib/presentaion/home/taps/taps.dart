import 'package:flutter/material.dart';
import 'package:news_app_route/core/theme/app_colors.dart';
import 'package:news_app_route/models/articles_response.dart';
import 'package:news_app_route/presentaion/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsTaps extends StatefulWidget {
  final HomeViewModel viewModel;
  final Article? article;


  const NewsTaps({Key? key, required this.viewModel,this.article}) : super(key: key);

  @override
  _NewsTapsState createState() => _NewsTapsState();
}

class _NewsTapsState extends State<NewsTaps> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    viewModel.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.source.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return DefaultTabController(
          length: viewModel.source.length,
          child: Column(
            children: [
              TabBar(
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                onTap: (index) {
                  viewModel.getArticles(viewModel.source[index]);
                },
                indicatorColor: AppColors.black,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                tabs: viewModel.source
                    .map((source) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(source.name ?? "Unknown"),
                ))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: viewModel.source.map((source) {
                    return viewModel.articles.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        var article = viewModel.articles[index];
                        return InkWell(
                          onTap: () {
                            _articlesDetailsButtonSheet(context, article);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            height: 360,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.black,
                                width: 3,
                              ),
                            ),
                            child: Column(
                              children: [
                                if (article.urlToImage != null)
                                  Container(
                                    width: 370,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(article.urlToImage!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? "No Title",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              article.author ?? "Unknown Author",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              formatDate(article.publishedAt),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: viewModel.articles.length,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _articlesDetailsButtonSheet(BuildContext context, Article article) {
    showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (article.urlToImage != null)
              Container(
                width: 370,
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(article.urlToImage!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    article.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(article.url);
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.inAppBrowserView);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Could not open URL")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("View Full Article"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

