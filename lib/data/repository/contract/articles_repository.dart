import '../../../models/articles_response.dart';

abstract interface class ArticlesRepository {
  Future<List<Article>> getArticles({required String sourceId});
}