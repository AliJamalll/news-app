import 'dart:io';

import 'package:news_app_route/data/api/api_manager.dart';

import '../../../models/articles_response.dart';
import '../contract/articles_remote_data_source.dart';

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource{
  ApiManager apiManager = ApiManager.instance;
  @override
  Future<List<Article>> getArticles({required String sourceId}) async{
    try{
      var response = await ApiManager.getArticles(sourceId: sourceId);
      return response!.articles;
    }on HttpException catch (_){
      rethrow;
    }on SocketException catch (_){
      rethrow;
    }on IOException catch (_){
      rethrow;
    }
  }
  }
