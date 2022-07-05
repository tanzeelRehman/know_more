import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import 'package:know_more/Constants.dart';
import 'package:know_more/Controllers/LoadNewsController.dart';
import 'package:know_more/Controllers/searchNewsController.dart';
import 'package:know_more/Models/Articles.dart';
import 'package:know_more/Models/NewsResponse.dart';

import 'package:know_more/service/DioExceptions.dart';
import 'package:know_more/service/Logging.dart';

class HttpServiceImpl {
  static var dio = Dio();
  var errormessage;

  // LoadNewsController _loadNewsController = Get.put(LoadNewsController());
  //https://newsapi.org/v2/top-headlines?country=us&apiKey=381e27083cf44c759ff04c4184adf506
  //GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=381e27083cf44c759ff04c4184adf506

  static Future<List<Article>?> getRequest(
      String query, int controllerno) async {
    Response response;
    print(query);
    try {
      response = await dio.get('v2/top-headlines?country=us');
      if (query == "Top") {
      } else {
        response = await dio.get('v2/everything?q=$query');
      }
      if (response.statusCode == 200) {
        print(response.data);
        var parsedjson = NewsResponse.fromJson(response.data);
        print(parsedjson.articles[0].title);
        return parsedjson.articles;
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      final errormessage = DioExceptions.fromDioError(e);
      if (controllerno == 1) {
        LoadNewsController.errormessage = errormessage.toString();
      } else {
        SearchNewsController.errormessage = errormessage.toString();
      }

      print(errormessage.toString());
      print("Error Sending Requst!");
    }
  }

  static void init() {
    var options = BaseOptions(
      baseUrl: kBASE_URL,
      headers: {"Authorization": "$kAPIKEY"},
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);

    dio.interceptors.add(Logging());
  }
}
