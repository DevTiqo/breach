import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';

class CategoryPost {
  final int id;

  final String name;
  final String icon;

  const CategoryPost({
    required this.id,
    required this.icon,
    required this.name,
  });

  factory CategoryPost.fromJson(Map<String, dynamic> responseData) {
    return CategoryPost(
      id: responseData['id'],
      icon: responseData['icon'],

      name: responseData['name'],
    );
  }
}
