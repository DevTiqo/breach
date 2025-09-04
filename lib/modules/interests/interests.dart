import 'dart:convert';
import 'dart:io';

import 'package:breach/models/category_model.dart';
import 'package:breach/models/interest_model.dart';
import 'package:breach/models/post_model.dart';
import 'package:breach/modules/http.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestApi {
  final Ref ref;

  InterestApi(this.ref);

  getInterests() async {
    String endpoint;

    try {
      print('dddwjndj');
      RequestResult result = await ref
          .read(httpProvider)
          .httpGetSec(
            "api/users/${ref.read(authNotifierProvider).user?.id.toString()}/interests",
            {},
          );
      print(result);
      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200) {
          List<Interest> interests = [];
          debugPrint("200 way post");

          print(result.data);
          List d = result.data as List;
          for (var element in d) {
            Interest thisinterests = Interest.fromJson(element);
            interests.add(thisinterests);
          }

          return RequestResult(true, 200, interests);
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

  saveInterests(List<int> interests) async {
    try {
      RequestResult result = await ref.read(httpProvider).httpMediaPost(
        "api/users/${ref.read(authNotifierProvider).user?.id.toString()}/interests",
        {"interests": interests},
      );
      print(result);
      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200 || result.status == 201) {
          return RequestResult(true, 200, 'Successfully save interests');
        } else {
          return RequestResult(
            false,
            400,
            result.data['message'] ?? "An Error Occurred, Try Again",
          );
        }
      } else {
        return RequestResult(
          false,
          400,
          result.data['message'] ??
              result.data['message'] ??
              "An Error Occurred, Try Again",
        );
      }
    } catch (error) {
      print(error);
      return RequestResult(false, 400, "Unknown Server Error, Try Again Later");
    }
  }
}
