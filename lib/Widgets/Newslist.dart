import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:know_more/Constants.dart';
import 'package:know_more/Controllers/LoadNewsController.dart';
import 'package:know_more/Database/Dbhelper.dart';
import 'package:know_more/Models/Articles.dart';
import 'package:know_more/service/Http_Service_Impl.dart';
import 'package:know_more/views/detailpage.dart';

class NewsList extends StatelessWidget {
  final String query;

  late final Dbhelper dbhelper;
  List<Article>? articleslist = [];
  NewsList({
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    LoadNewsController controller = Get.put(LoadNewsController());

    return FutureBuilder(
        future: controller.getNews(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => ListView.builder(
                  itemCount: controller.articleslist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      singlearticle:
                                          controller.articleslist[index],
                                      check: 1,
                                    )),
                          ),
                          child: Row(children: [
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    width: 80,
                                    image: NetworkImage(controller
                                            .articleslist[index].urlToImage ??
                                        "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg"),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(controller.articleslist[index].title ??
                                        "(No title)"),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
