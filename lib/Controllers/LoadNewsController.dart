import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:know_more/Models/Articles.dart';
import 'package:know_more/service/Http_Service_Impl.dart';

class LoadNewsController extends GetxController {
  var articleslist = List<Article>.empty().obs;

  static late String errormessage;

  Future<List<Article>?> getNews(String query) async {
    try {
      HttpServiceImpl.init();
      return articleslist.value = (await HttpServiceImpl.getRequest(
          query, 1))!; //1 means calling from loadnews controller
    } catch (e) {
      print(errormessage);
      return null;
    }
  }
}
