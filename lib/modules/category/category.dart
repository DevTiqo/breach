import 'dart:convert';
import 'dart:io';

import 'package:breach/models/category_model.dart';
import 'package:breach/models/post_model.dart';
import 'package:breach/modules/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryApi {
  final Ref ref;

  CategoryApi(this.ref);

  getCategories() async {
    String endpoint;

    try {
      print('dddwjndj');
      RequestResult result = await ref
          .read(httpProvider)
          .httpGetSec("api/blog/categories", {});
      print(result.ok);
      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200) {
          List<CategoryPost> categorypost = [];
          debugPrint("200 way post");

          print(result.data);
          List d = result.data as List;
          for (var element in d) {
            CategoryPost thiscategorypost = CategoryPost.fromJson(element);
            categorypost.add(thiscategorypost);
          }

          return RequestResult(true, 200, categorypost);
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
}
