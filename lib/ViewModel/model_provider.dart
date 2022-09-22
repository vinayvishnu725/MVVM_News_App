import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:search_news/Models/news_model.dart';
import 'package:search_news/Services/network_api_service.dart';

class ModelProvider {
  final _networkApiService = NetworkApiService();

//calling Network Api service to get news data
  Future getNewsData(context) async {
    final data = await _networkApiService.getNewsAPI();
    if (data["isSuccess"]) {
      // print(data["isSuccess"]);

      //storing state using provider
      Provider.of<NewsModel>(context, listen: false)
          .fromJson(jsonDecode(data["data"]));
      return true;
    } else {
      return false;
    }
  }
}
