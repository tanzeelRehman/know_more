import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_more/Controllers/Save_artical_controller.dart';
import 'package:know_more/Controllers/searchNewsController.dart';
import 'package:know_more/Database/Dbhelper.dart';
import 'package:know_more/Models/Articles.dart';
import 'package:know_more/views/detailpage.dart';

class SaveArticle extends StatelessWidget {
  String? query;

  TextEditingController querycontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SaveArticalController articalslistcontroller =
        Get.put(SaveArticalController());
    articalslistcontroller.getArticle(query);

    print("length is");
    print(articalslistcontroller.articleslist.length);

    return Scaffold(
        appBar: AppBar(
          title: Text("Saved Articles"),
        ),
        body: Column(
          children: [
            TextFormField(
              onChanged: (String? inputvalue) {
                query = inputvalue;
                articalslistcontroller.getArticle(query);
              },
              controller: querycontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search here",
              ),
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                  itemCount: articalslistcontroller.articleslist.length,
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
                                      singlearticle: articalslistcontroller
                                          .articleslist[index],
                                      check: 2,
                                    )),
                          ),
                          child: Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  width: 80,
                                  image: NetworkImage(articalslistcontroller
                                          .articleslist[index].urlToImage ??
                                      "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(articalslistcontroller
                                            .articleslist[index].title ??
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
            )),
          ],
        ));
  }
}
