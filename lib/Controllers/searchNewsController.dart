import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:know_more/Models/Articles.dart';
import 'package:know_more/service/Http_Service_Impl.dart';

class SearchNewsController extends GetxController {
  var articleslist = List<Article>.empty().obs;
  var loading = false.obs;
  static late String errormessage;
  var check = false.obs;

  void loadNews(
    String queryvalue,
  ) async {
    try {
      showloading();
      HttpServiceImpl.init();
      articleslist.value = (await HttpServiceImpl.getRequest(
          queryvalue, 2))!; //2 means calling from search controller
      hideloading();
    } catch (e) {
      print(errormessage);
    }
  }

  showloading() {
    loading.toggle();
  }

  hideloading() {
    loading.toggle();
  }
}
