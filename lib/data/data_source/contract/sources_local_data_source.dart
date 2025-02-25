import '../../../models/sourcres_model.dart';

abstract interface class SourcesLocalDataSource {
  Future<void> saveSources({required List<Source> sources});
}