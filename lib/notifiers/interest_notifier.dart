import 'package:breach/models/category_model.dart';
import 'package:breach/models/interest_model.dart';
import 'package:breach/modules/http.dart';
import 'package:breach/modules/interests/interests.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart'; // where httpProvider, authNotifierProvider, RequestResult live

final interestsProvider = FutureProvider<List<Interest>>((ref) async {
  try {
    final RequestResult result = await InterestApi(ref).getInterests();

    if (result.ok && result.status == 200 || result.status == 201) {
      final List<Interest> data = result.data as List<Interest>;
      return data;
    } else {
      throw Exception(result.data['message'] ?? "An error occurred");
    }
  } catch (e) {
    throw Exception("Failed to load interests: $e");
  }
});

final interestsApiProvider = Provider<InterestApi>((ref) {
  return InterestApi(ref);
});
