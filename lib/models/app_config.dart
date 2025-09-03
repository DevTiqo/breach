import 'package:breach/router.dart';
import 'package:flutter/material.dart';

// 1
enum Environment { dev, staging, prod }

class ApiGateway {
  final String coreUrl;
  final String socketUrl;
  final String shareLinkUrl;
  final String clientIDWeb;
  final String clientiOS;
  final String clientAndroid;
  final String serverID;

  const ApiGateway({
    required this.coreUrl,
    required this.socketUrl,
    required this.shareLinkUrl,
    required this.clientIDWeb,
    required this.clientiOS,
    required this.clientAndroid,
    required this.serverID,
  });
}

// 2
class AppConfig extends InheritedWidget {
  // 3
  final Environment environment;
  final String appTitle;
  final ApiGateway apiGateway;
  final AppRouter appRouter;

  // 4
  const AppConfig({
    Key? key,
    required Widget child,
    required this.environment,
    required this.apiGateway,
    required this.appTitle,
    required this.appRouter,
  }) : super(key: key, child: child);

  // 5
  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  // 6
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
