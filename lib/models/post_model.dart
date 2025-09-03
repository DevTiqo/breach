import 'package:breach/models/category_model.dart';
import 'package:flutter/material.dart';

class Post {
  final int id;

  final String title;
  final String content;
  final String description;
  final DateTime createdAt;
  final String imageUrl;
  final CategoryPost category;
  final Author author;
  final Series series;

  Post({
    required this.id,
    required this.content,

    required this.description,

    required this.title,
    required this.createdAt,
    this.imageUrl = "",
    required this.category,
    required this.author,
    required this.series,
  });

  factory Post.fromJson(Map<String, dynamic> responseData) {
    // List d = responseData['images'];
    print("Post SS");

    debugPrint(responseData['images'].toString());

    return Post(
      id: responseData['id_Post'],
      content: responseData['content'],

      description: responseData['description'],
      title: responseData['title'],
      createdAt:
          DateTime.tryParse(responseData['created_at'])?.toLocal() ??
          DateTime.now(),
      imageUrl: responseData['imageUrl'],
      category: CategoryPost.fromJson(responseData['category']),
      author: Author.fromJson(responseData['author']),
      series: Series.fromJson(responseData['series']),
    );
  }
}

class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> responseData) {
    return Author(id: responseData['id'], name: responseData['name']);
  }
}

class Series {
  final int id;
  final String name;

  Series({required this.id, required this.name});

  factory Series.fromJson(Map<String, dynamic> responseData) {
    return Series(id: responseData['id'], name: responseData['name']);
  }
}
