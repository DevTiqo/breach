import 'package:breach/models/app_config.dart';
import 'package:breach/modules/auth/auth.dart';
import 'package:breach/modules/category/category.dart';
import 'package:breach/modules/post/post.dart';
import 'package:breach/notifiers/appConfigNotifier.dart';
import 'package:breach/notifiers/categoriesNotifier.dart';
import 'package:breach/notifiers/postsNotifier.dart';
import 'package:breach/notifiers/auth_notifier.dart';
import 'package:breach/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  return AuthNotifier(auth: Auth(ref));
});

final themeNotifier = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

final appConfigNotifierProvider =
    StateNotifierProvider<AppConfigNotifier, AppConfig?>((ref) {
      return AppConfigNotifier();
    });

final postsNotifierProvider = StateNotifierProvider<PostNotifier, PostState>((
  ref,
) {
  return PostNotifier(postApi: PostApi(ref));
});

final categoriesNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
      return CategoryNotifier(postApi: CategoryApi(ref));
    });
