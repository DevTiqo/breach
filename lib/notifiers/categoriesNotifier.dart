import 'dart:convert';
import 'dart:io';

import 'package:breach/models/category_model.dart';
import 'package:breach/models/post_model.dart';
import 'package:breach/modules/category/category.dart';
import 'package:breach/modules/post/post.dart';
import 'package:breach/modules/http.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<CategoryPost>>((ref) async {
  try {
    final RequestResult result = await CategoryApi(ref).getCategories();

    if (result.ok && result.status == 200 || result.status == 201) {
      final List<CategoryPost> data = result.data as List<CategoryPost>;
      return data;
    } else {
      throw Exception(result.data['message'] ?? "An error occurred");
    }
  } catch (e) {
    throw Exception("Failed to load categories: $e");
  }
});

class CategoryState {
  final List<CategoryPost> categories;

  final CategoryPost? currentCategory;

  CategoryState({this.categories = const [], this.currentCategory});

  CategoryState copyWith({
    List<CategoryPost>? categories,
    CategoryPost? currentCategory,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }
}

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryApi postApi;
  CategoryNotifier({required this.postApi}) : super(CategoryState());

  void setCurrentCategory(CategoryPost cpost) async {
    state = CategoryState(currentCategory: cpost);
  }

  setCategories(List<CategoryPost> categories) {
    state = state.copyWith(
      categories: categories,
      currentCategory: state.currentCategory ?? categories[0],
    );
  }

  Future<RequestResult> getCategories() async {
    RequestResult req = RequestResult(false, 400, "yet to call");

    req = await postApi.getCategories();
    debugPrint(req.ok.toString());
    if (req.ok) {
      // reqq = req;
      debugPrint("okayy");
      List<CategoryPost> posts = req.data as List<CategoryPost>;

      setCategories(posts);

      return req;
    } else {
      debugPrint(req.data);
      return req;
    }
  }
}
