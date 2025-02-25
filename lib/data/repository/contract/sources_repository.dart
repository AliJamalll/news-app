import '../../../models/sourcres_model.dart';

abstract interface class SourcesRepository {
  Future<List<Source>> getSources({required String catId});
}