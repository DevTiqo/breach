import 'package:breach/models/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfigNotifier extends StateNotifier<AppConfig?> {
  AppConfigNotifier() : super(null);

  initializeApp(AppConfig config) {
    state = config;
  }
}
