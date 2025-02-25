import 'dart:convert';

import 'package:news_app_route/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_route/models/articles_response.dart';
import '../../models/sourcres_model.dart';

class ApiManager{

  ApiManager._();
  static ApiManager? apiManager;
  static get instance{
    apiManager ??= ApiManager._();
    return apiManager;
  }

   Future<sourcesModel?> getSources({required String catId})async{
    var url = Uri.https(ApiConstants.baseUrl,ApiConstants.sources,{
      "category" : catId
    });
    var response = await http.get(url,headers: {
      "Authorization" : "Bearer ${ApiConstants.apiKey}"
    });

    if(response.statusCode == 200){
      return sourcesModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ArticlesResponse?> getArticles({required String sourceId})async{
    var url = Uri.https(ApiConstants.baseUrl,ApiConstants.headLinesRoute,{
      "sources" : sourceId
    });
    var response = await http.get(url,headers: {
      "Authorization" : "Bearer ${ApiConstants.apiKey}"
    });

    if(response.statusCode == 200){
      return ArticlesResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ArticlesResponse?> searchArticles({required String searchQuery, required int pageNumber, })async{
    var url = Uri.https(ApiConstants.baseUrl,ApiConstants.SearchRoute,{
      "q" : searchQuery,
      "page" : pageNumber.toString(),
      "pageSize" : "10"
    });
    var response = await http.get(url,headers: {
      "Authorization" : "Bearer ${ApiConstants.apiKey}"
    });

    if(response.statusCode == 200){
      return ArticlesResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

}