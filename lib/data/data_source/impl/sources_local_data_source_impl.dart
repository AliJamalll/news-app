import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/sourcres_model.dart';
import '../contract/sources_local_data_source.dart';

class SourcesLocalDataSourceImpl implements SourcesLocalDataSource {
  @override
  Future<void> saveSources({required List<Source> sources}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sources', sources.toString());
  }
}