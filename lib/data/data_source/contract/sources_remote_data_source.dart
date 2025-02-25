import '../../../models/sourcres_model.dart';

abstract interface class SourcesRemoteDataSource {
  Future<List<Source>> getSources({required String catId});
}
