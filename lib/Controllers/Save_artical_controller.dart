import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:know_more/Database/Dbhelper.dart';

import 'package:know_more/Models/Articles.dart';
import 'package:know_more/service/Http_Service_Impl.dart';

class SaveArticalController extends GetxController {
  var articleslist = List<Article>.empty().obs;
  late Dbhelper dbhelper;
  static late String errormessage;

  Future getArticle(String? query) async {
    print("in saveartical controller");
    dbhelper = new Dbhelper();
    try {
      if (query == null) {
        print("null query");
        print(query);
        articleslist.value = await dbhelper.queryAll();
        print('data fetched');
      } else {
        print("not null query");
        print(query);
        articleslist.value = await dbhelper.queryOnly(query);
      }

      print("this is title");
      print(articleslist.length);
    } catch (e) {
      print(errormessage);
    }
  }
}
