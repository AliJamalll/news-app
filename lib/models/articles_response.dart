import 'dart:convert';

ArticlesResponse articlesResponseFromJson(String str) =>
    ArticlesResponse.fromJson(json.decode(str));

String articlesResponseToJson(ArticlesResponse data) =>
    json.encode(data.toJson());

class ArticlesResponse {
    ArticlesResponse({
        required this.totalResults,
        required this.articles,
        required this.status,
    });

    int totalResults;
    List<Article> articles;
    String status;

    factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
        ArticlesResponse(
            totalResults: json["totalResults"] ?? 0,
            articles: json["articles"] != null
                ? List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x)))
                : [],
            status: json["status"] ?? "unknown",
        );

    Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "status": status,
    };
}

class Article {
    Article({
        required this.publishedAt,
        this.author,
        this.urlToImage,
        this.description,
        required this.source,
        required this.title,
        required this.url,
        this.content,
    });

    DateTime publishedAt;
    String? author;
    String? urlToImage;
    String? description;
    Source source;
    String title;
    String url;
    String? content;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        publishedAt: json["publishedAt"] != null
            ? DateTime.tryParse(json["publishedAt"]) ?? DateTime.now()
            : DateTime.now(),
        author: json["author"], // Allow nullable author
        urlToImage: json["urlToImage"], // Allow nullable image
        description: json["description"], // Allow nullable description
        source: Source.fromJson(json["source"] ?? {}),
        title: json["title"] ?? "No Title",
        url: json["url"] ?? "#",
        content: json["content"], // Allow nullable content
    );

    Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "author": author,
        "urlToImage": urlToImage,
        "description": description,
        "source": source.toJson(),
        "title": title,
        "url": url,
        "content": content,
    };
}

class Source {
    Source({
        this.name,
        this.id,
    });

    String? name;
    String? id;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
