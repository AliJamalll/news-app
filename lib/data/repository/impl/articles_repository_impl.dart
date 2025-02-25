import 'package:news_app_route/data/data_source/contract/articles_remote_data_source.dart';
import 'package:news_app_route/data/data_source/impl/articles_remote_data_source_impl.dart';

import '../../../models/articles_response.dart';
import '../contract/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRemoteDataSource remoteDataSource = ArticlesRemoteDataSourceImpl();
  @override
  Future<List<Article>> getArticles({required String sourceId}) async {
    return remoteDataSource.getArticles(sourceId: sourceId);
  }
}