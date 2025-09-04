import 'package:breach/models/category_model.dart';
import 'package:breach/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';

class Interest {
  final int id;
  final User? user;
  final CategoryPost? category;

  const Interest({
    required this.id,
    required this.user,
    required this.category,
  });

  factory Interest.fromJson(Map<String, dynamic> responseData) {
    CategoryPost? thiscategory = responseData['category'] != null
        ? CategoryPost.fromJson(responseData['category'])
        : null;
    User? thisuser = responseData['user'] != null
        ? User.fromJson(responseData['user'])
        : null;

    return Interest(
      id: responseData['id'],
      user: thisuser,
      category: thiscategory,
    );
  }
}
