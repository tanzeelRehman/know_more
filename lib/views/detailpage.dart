import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_more/Database/Dbhelper.dart';

import 'package:know_more/Models/Articles.dart';

class DetailPage extends StatelessWidget {
  Article singlearticle;
  final int? check;

  late final Dbhelper dbhelper;
  DetailPage({
    Key? key,
    this.check,
    required this.singlearticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Printing check value & id");

    return Scaffold(
      body: Column(
        children: [
          Image(
              fit: BoxFit.cover,
              image: NetworkImage(singlearticle.urlToImage ??
                  "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg")),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    singlearticle.title ?? "(No Title)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon:
                              Icon(check == 1 ? Icons.bookmark : Icons.delete),
                          onPressed: () {
                            print(singlearticle.id);
                            dbhelper = new Dbhelper();
                            if (check == 1) {
                              print("in detail page");
                              print(singlearticle.title);
                              dbhelper.insertArticle(singlearticle);
                                    Get.snackbar("Sucess", "Article saves scuessfully");
                            } else {
                              dbhelper.deleteTask(singlearticle.id!);
                                    Get.snackbar("Sucess", "Article deleted scuessfully");
                            }

                      
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
                          singlearticle.author!.length < 15
                              ? Text(singlearticle.author ?? "(No Title)")
                              : Text("No Name"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.timer),
                          Text(singlearticle.publishedAt),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(singlearticle.desc ?? "(No Desc)")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
