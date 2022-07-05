import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_more/Controllers/LoadNewsController.dart';

import 'package:know_more/Widgets/Newslist.dart';
import 'package:know_more/views/save_article_page.dart';
import 'package:know_more/views/search_page.dart';

class HomePage extends StatelessWidget {
  List tabs = [
    "Top",
    "Buisness",
    "Sports",
    "Health",
    "Technology",
    "Entertainment"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Row(
              children: [
                Text("Know"),
                Text(
                  "More",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Top",
                ),
                Tab(
                  text: "Buisness",
                ),
                Tab(
                  text: "Sports",
                ),
                Tab(
                  text: "Health",
                ),
                Tab(
                  text: "Technology",
                ),
                Tab(
                  text: "Entairtnmanet",
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => Get.to(() => SearchPage())),
              IconButton(
                  icon: Icon(Icons.radio_button_checked),
                  onPressed: () {
                    Get.isDarkMode
                        ? Get.changeTheme(ThemeData.light())
                        : Get.changeTheme(ThemeData.dark());
                  }),
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: GestureDetector(
                    onTap: () => Get.to(() => SaveArticle()),
                    child: ListTile(
                      leading: Icon(
                        Icons.bookmark,
                      ),
                      title: Text("Open Save items"),
                      subtitle: Text("subtitle"),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            NewsList(
              query: "Top",
            ),
            NewsList(
              query: "Buisness",
            ),
            NewsList(
              query: "Sports",
            ),
            NewsList(
              query: "Health",
            ),
            NewsList(
              query: "Technology",
            ),
            NewsList(
              query: "Entairtnmanet",
            ),
          ]),
        ));
  }
}
