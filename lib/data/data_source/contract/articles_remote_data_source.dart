import '../../../models/articles_response.dart';

abstract interface class ArticlesRemoteDataSource {
  Future<List<Article>> getArticles({required String sourceId});
}