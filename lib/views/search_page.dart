import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_more/Controllers/LoadNewsController.dart';
import 'package:know_more/Controllers/searchNewsController.dart';
import 'package:know_more/Widgets/Newslist.dart';
import 'package:know_more/views/detailpage.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SearchNewsController controller = Get.put(SearchNewsController());
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          print(searchcontroller.text);
                          controller.check.value = true;
                          controller.loadNews(searchcontroller.text.toString());
                        }),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Obx(
            () => Container(
              child: controller.check.value == false
                  ? Container()
                  : controller.loading.isTrue
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Loading..."),
                        )
                      : ListView.builder(
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
                                              singlearticle: controller
                                                  .articleslist[index],
                                              check: 1,
                                            )),
                                  ),
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image(
                                          width: 80,
                                          image: NetworkImage(controller
                                                  .articleslist[index]
                                                  .urlToImage ??
                                              "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(controller.articleslist[index]
                                                    .title ??
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
            ),
          ))
        ],
      ),
    );
  }
}
