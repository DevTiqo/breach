import 'dart:convert';
import 'dart:io';

import 'package:breach/models/category_model.dart';
import 'package:breach/models/post_model.dart';
import 'package:breach/modules/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostApi {
  final Ref ref;

  PostApi(this.ref);

  getPosts(int categoryId) async {
    String endpoint;

    try {
      RequestResult result = await ref
          .read(httpProvider)
          .httpGetSec("api/blog/posts?categoryId=$categoryId", {});
      print(result.data);
      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200) {
          List<Post> post = [];
          debugPrint("200 way post");

          print(result.data);
          List d = result.data as List;
          for (var element in d) {
            // Post postpost = Post.fromJson(element);
            // post.add(postpost);
          }

          return RequestResult(true, 200, post);
        } else {
          return RequestResult(false, 400, result.data['message']);
        }
      } else {
        print(result.data);
        return RequestResult(
          false,
          400,
          result.data['message'] ?? "An Error Occurred, Try Again",
        );
      }
    } catch (error) {
      print(error);
      return RequestResult(false, 400, "Unknown Server Error, Try Again Later");
    }
  }

  getCategories(int start) async {
    String endpoint;

    try {
      RequestResult result = await ref
          .read(httpProvider)
          .httpGetSec("api/blog/posts?categoriesId=$start", {});
      // debugPrint(result.data);
      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200) {
          List<CategoryPost> categories = [];
          debugPrint("200 way post");

          // debugPrint(result.data['data']);
          List d = result.data['data'] as List;
          for (var element in d) {
            CategoryPost thiscategory = CategoryPost.fromJson(element);
            categories.add(thiscategory);
          }

          // UserPreferences().saveUser(authUser);

          return RequestResult(true, 200, categories);
        } else {
          return RequestResult(false, 400, result.data['message']);
        }
      } else {
        // debugPrint(result.data);
        return RequestResult(
          false,
          400,
          result.data['message'] ?? "An Error Occurred, Try Again",
        );
      }
    } catch (error) {
      return RequestResult(false, 400, "Unknown Server Error, Try Again Later");
    }
  }
}
