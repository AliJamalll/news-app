import 'package:news_app_route/data/data_source/contract/sources_local_data_source.dart';

import '../../../models/sourcres_model.dart';
import '../../data_source/contract/sources_remote_data_source.dart';
import '../../data_source/impl/sources_local_data_source_impl.dart';
import '../../data_source/impl/sources_remote_data_source_impl.dart';
import '../contract/sources_repository.dart';

class SourcesRepositoryImpl implements SourcesRepository{
  SourcesRemoteDataSource sourcesRemoteDataSource = SourcesRemoteDataSourceImpl();
  SourcesLocalDataSource sourcesLocalDataSource = SourcesLocalDataSourceImpl();

  @override
  Future<List<Source>> getSources({required String catId}) async {
    var response = await sourcesRemoteDataSource.getSources(catId: catId);
    sourcesLocalDataSource.saveSources(sources: response);
    return response;
  }
}