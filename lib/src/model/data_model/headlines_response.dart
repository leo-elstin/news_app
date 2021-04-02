// To parse this JSON data, do
//
//     final headlinesResponse = headlinesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:news_app/src/model/data_model/article.dart';


HeadlinesResponse headlinesResponseFromJson(String str) =>
    HeadlinesResponse.fromJson(json.decode(str));

String headlinesResponseToJson(HeadlinesResponse data) =>
    json.encode(data.toJson());

class HeadlinesResponse {
  HeadlinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory HeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      HeadlinesResponse(
        status: json["status"] == null ? null : json["status"],
        totalResults:
            json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}



class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
