class ResHomeModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  ResHomeModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ResHomeModel.fromJson(Map<String, dynamic> json) => ResHomeModel(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: json['articles'] == null
            ? null
            : List<Article>.from((json['articles'] as List).map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles == null ? null : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  String? author;
  String? title;
  String? url;
  String? publishedAt;

  Article({
    this.author,
    this.title,
    this.url,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json['author'],
        title: json['title'],
        url: json['urlToImage'],
        publishedAt: json['publishedAt'],
      );

  Map<String, dynamic> toJson() => {'author': author, 'title': title, 'urlToImage': url, 'publishedAt': publishedAt};
}
