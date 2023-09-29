import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:icare_news_app/model/article.dart';

class News {
  String status;
  int totalResults;
  List<Article> articles;
  News({required this.status, required this.totalResults, required this.articles});

  News copyWith({String? status, int? totalResults, List<Article>? articles}) {
    return News(status: status ?? this.status, totalResults: totalResults ?? this.totalResults, articles: articles ?? this.articles);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'status': status, 'totalResults': totalResults, 'articles': articles.map((x) => x.toMap()).toList()};
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      status: map['status'] ?? "",
      totalResults: map['totalResults'] ?? 0,
      articles: List<Article>.from(
        (map['articles'] as List<dynamic>).map<Article>(
          (x) => Article.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'News(status: $status, totalResults: $totalResults, articles: $articles)';

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.status == status && other.totalResults == totalResults && listEquals(other.articles, articles);
  }

  @override
  int get hashCode => status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}
