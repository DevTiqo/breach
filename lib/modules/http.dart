import 'dart:convert';
import 'dart:io';

import 'package:breach/notifiers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:http/retry.dart';

class RequestResult {
  bool ok;
  int status;
  dynamic data;
  RequestResult(this.ok, this.status, this.data);
}

final Provider httpProvider = Provider(
  (ref) => HttpRepository(
    ref,
    RetryClient(
      http.Client(),
      retries: 2,
      when: (baseresponse) {
        print(baseresponse.request!.url!.toString());
        print('sssss////////////////////////');
        if (baseresponse.statusCode == 401 &&
            !baseresponse.request!.url!.toString().contains('refreshToken')) {
          // TokenInterceptor().interceptRequest(data: response.request!);
          // print(response);
          // TokenRepository(ref).refreshToken();
          return true;
        }

        return false;
      },
      whenError: (p0, p1) {
        return false;
      },
      onRetry: (baserequest, baseresponse, retryCount) async {
        try {
          // await TokenRepository(ref).refreshToken();
          final Box box = await Hive.openBox('user');
          String? token = await box.get('token') ?? "";

          baserequest.headers.removeWhere(
            (key, value) => key == "authorization",
          );

          baserequest.headers["authorization"] = "Bearer " + token!;
        } catch (e) {
          debugPrint(e.toString());
        }
        // return baserequest;
      },
    ),
  ),
);

class HttpRepository {
  Ref ref;
  RetryClient client;

  HttpRepository(this.ref, this.client);

  Future<RequestResult> httpGet(String route, [dynamic data]) async {
    var dataStr = jsonEncode(data);
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";
    Uri encoded = Uri.parse(url);
    var result = await http.get(
      encoded,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    // debugPrint(result.statusCode.toString());
    print(result.statusCode);
    return RequestResult(
      jsonDecode(result.body)["success"] ?? true,
      result.statusCode,
      jsonDecode(result.body),
    );
  }

  Future<RequestResult> httpGetSec(String route, [dynamic data]) async {
    var dataStr = jsonEncode(data);
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";
    Uri encoded = Uri.parse(url);
    final Box box = await Hive.openBox('user');
    String token = await box.get('token') ?? "";
    var result = await client.get(
      encoded,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      },
    );

    return RequestResult(
      jsonDecode(result.body)["success"] ?? true,
      result.statusCode,
      jsonDecode(result.body),
    );
  }

  Future<RequestResult> httpPost(String route, [dynamic data]) async {
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";
    Uri encoded = Uri.parse(url);
    var dataStr = jsonEncode(data);
    var result = await client.post(
      encoded,
      body: dataStr,
      headers: {
        "Content-Type": "application/json",
        // "Access-Control-Allow-Origin": "*"
      },
    );
    return RequestResult(
      jsonDecode(result.body)["success"] ?? true,
      result.statusCode,
      jsonDecode(result.body),
    );
  }

  Future<RequestResult> httpPostSec(String route, [dynamic data]) async {
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";
    Uri encoded = Uri.parse(url);
    var dataStr = jsonEncode(data);
    final Box box = await Hive.openBox('user');
    String token = await box.get('token') ?? "";
    var result = await client.post(
      encoded,
      body: dataStr,
      headers: {
        // "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      },
    );

    return RequestResult(
      jsonDecode(result.body)["success"] ?? true,
      result.statusCode,
      jsonDecode(result.body),
    );
  }

  Future<RequestResult> httpDeleteSec(String route, [dynamic data]) async {
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";
    Uri encoded = Uri.parse(url);
    var dataStr = jsonEncode(data);
    final Box box = await Hive.openBox('user');
    String token = await box.get('token') ?? "";
    var result = await client.delete(
      encoded,
      body: dataStr,
      headers: {
        // "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      },
    );

    return RequestResult(
      jsonDecode(result.body)["success"] ?? true,
      result.statusCode,
      jsonDecode(result.body),
    );
  }

  // Future<RequestResult> httpFilePost(String route, [dynamic data]) async {
  //   var url =
  //       ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";

  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers['Content-Type'] = "multipart/form-data";
  //   request.headers["Access-Control-Allow-Origin"] = "*";
  //   final Box box = await Hive.openBox('user');
  //   String token = await box.get('token') ?? "";
  //   request.headers['authorization'] = "Bearer " + token;

  //   List<Map<String, dynamic>> uploadspath = data['media'];
  //   if (uploadspath.length > 0) {
  //     uploadspath.forEach((element) async {
  //       request.files.add(http.MultipartFile.fromBytes('media', element['blob'],
  //           filename: element['name']));
  //     });
  //   }

  //   request.fields['user_id'] = data['user_id'];
  //   request.fields['platforms'] = jsonEncode(data['platforms']);
  //   request.fields['account_id'] = data['account_id'];
  //   request.fields['content'] = data['content'];
  //   request.fields['hashtag'] = data['hashtag'];
  //   request.fields['company_id'] = data['company_id'];

  //   if (data['isScheduled'] == 1) {
  //     request.fields['schedule_date'] = data['schedule_date'].toString();
  //   }

  //   var result = await request.send();
  //   debugPrint(data['token']);
  //   return RequestResult(true, result.statusCode,
  //       jsonDecode(await result.stream.bytesToString()));
  //   // return RequestResult(true, 200, {});
  // }

  Future<RequestResult> httpMediaPost(String route, [dynamic data]) async {
    var url =
        ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Content-Type'] = "multipart/form-data";
    request.headers["Access-Control-Allow-Origin"] = "*";
    final Box box = await Hive.openBox('user');
    String token = await box.get('token') ?? "";
    request.headers['authorization'] = "Bearer " + token;

    List<File?>? uploadspath = data['media'];
    if (uploadspath != null && uploadspath.isNotEmpty) {
      for (var element in uploadspath) {
        if (element != null) {
          var type = 'jpeg';
          var extn = element.path.split('.').last;
          if (extn == 'jpg') {
            type = 'jpeg';
          } else if (extn == 'png') {
            type = 'png';
          } else if (extn == 'gif') {
            type = 'gif';
          }

          request.files.add(
            await http.MultipartFile.fromPath(
              'media',
              element.path,
              contentType: MediaType('image', type),
            ),
          );
        }
      }
    }

    File? videouploadspath = data['video'];
    print('video');
    if (videouploadspath != null) {
      var type = 'mp4';
      print('video');
      print(videouploadspath.path);
      var extn = videouploadspath.path.split('.').last;
      if (extn == 'mp4') {
        type = 'mp4';
      } else if (extn == 'h264') {
        type = 'h264';
      } else if (extn == 'quicktime') {
        type = 'quicktime';
      } else if (extn == 'raw') {
        type = 'raw';
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videouploadspath.path,
          contentType: MediaType('video', type),
        ),
      );
    }

    data as Map<String, dynamic>;
    data.forEach((key, value) {
      if (key != "media" && key != "video" && value is List) {
        for (int i = 0; i < value.length; i++) {
          request.fields['$key[$i]'] = '${value[i]}';
        }
      } else if (key != "media" && key != "video" && value != null) {
        request.fields[key.toString()] = value.toString();
      }
    });

    // if (data['isScheduled'] == 1) {
    //   request.fields['schedule_date'] = data['schedule_date'].toString();
    // }

    print(request.fields);

    var result = await request.send();
    debugPrint(result.statusCode.toString());
    return RequestResult(
      true,
      result.statusCode,
      jsonDecode(await result.stream.bytesToString()),
    );
    // return RequestResult(true, 200, {});
  }

  // Future<RequestResult> httpProfilePosts(String route, [dynamic data]) async {
  //   var url =
  //       ref.read(appConfigNotifierProvider)!.apiGateway.coreUrl + "/$route";

  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers['Content-Type'] = "multipart/form-data";
  //   request.headers["Access-Control-Allow-Origin"] = "*";
  //   final Box box = await Hive.openBox('user');
  //   String token = await box.get('token') ?? "";
  //   request.headers['authorization'] = "Bearer " + token;

  //   Map<String, dynamic> upload = data['profile_img'];
  //   if (upload.isNotEmpty) {
  //     debugPrint(data['profile_img']['blob']);
  //     debugPrint(data['profile_img']['name']);
  //     request.files.add(http.MultipartFile.fromBytes(
  //         'profile_img', data['profile_img']['blob'],
  //         filename: data['profile_img']['name']));
  //   }

  //   data as Map<String, dynamic>;
  //   data.forEach((key, value) {
  //     request.fields[key.toString()] = value.toString();
  //   });

  //   // if (data['isScheduled'] == 1) {
  //   //   request.fields['schedule_date'] = data['schedule_date'].toString();
  //   // }

  //   var result = await request.send();
  //   return RequestResult(true, result.statusCode,
  //       jsonDecode(await result.stream.bytesToString()));
  //   // return RequestResult(true, 200, {});
  // }
}
