import 'dart:io';

import 'package:breach/models/user_model.dart';
import 'package:breach/modules/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// import '../hiveservice.dart';

// final HiveService hiveService = HiveService();

class Auth {
  final Ref ref;

  Auth(this.ref);

  register(String email, String password) async {
    try {
      RequestResult result = await ref.read(httpProvider).httpPost(
        "api/auth/register",
        {"email": email, "password": password},
      );

      print(result.status.toString() + 'sss');

      if (result.ok) {
        debugPrint("OK resultu");
        print(result.data);

        if (result.status == 200 || result.status == 201) {
          debugPrint("200 way");

          User authUser = User.fromJson(result.data);

          return RequestResult(true, 200, authUser);
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

  login(String email, String password) async {
    try {
      RequestResult result = await ref.read(httpProvider).httpPost(
        "api/auth/login",
        {"email": email, "password": password},
      );

      if (result.ok) {
        debugPrint("OK resultu");

        if (result.status == 200) {
          User authUser = User.fromJson(result.data);

          return RequestResult(true, 200, authUser);
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
