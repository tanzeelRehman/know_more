import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(jsonDecode(str));

class Article {
  String? author;

  String? desc;

  String? title;

  String? urlToImage;

  String? url;

  String? content;

  String publishedAt;

  int? id;

  Article({
    this.author,
    this.title,
    this.desc,
    required this.publishedAt,
    this.url,
    this.urlToImage,
    this.content,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'desc': desc,
      'publishedAt': publishedAt,
      'url': url,
      'urlToImage': urlToImage
    };
  }

  DateTime get getPublishedAtDate => DateTime.parse(publishedAt);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json["title"],
      publishedAt: json["publishedAt"],
      author: json["author"],
      desc: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      content: json["content"],
    );
  }
}
