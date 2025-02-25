import 'dart:io';

import 'package:news_app_route/data/api/api_manager.dart';

import '../../../models/sourcres_model.dart';
import '../contract/sources_remote_data_source.dart';

class SourcesRemoteDataSourceImpl implements SourcesRemoteDataSource {

  ApiManager apiManager= ApiManager.instance;

  @override
  Future<List<Source>> getSources({required String catId}) async {
    try{
      var response = await apiManager.getSources(catId: catId);
      return response!.sources;
    }on HttpException catch (_){
      rethrow;
    }on SocketException catch (_){
      rethrow;
  }on IOException catch (_){
      rethrow;
    }
  }
}