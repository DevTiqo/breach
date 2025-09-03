import 'package:breach/main.dart';
import 'package:breach/screens/contentinterest.dart';
import 'package:breach/screens/createaccount.dart';
import 'package:breach/screens/home/navhome.dart';
import 'package:breach/screens/landing.dart';
import 'package:breach/screens/login.dart';
import 'package:breach/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

bool isLoggedIn = false;
bool firstTime = true;
bool loggingIn = false;

class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,

    routes: <RouteBase>[
      GoRoute(
        name: '/',
        path: '/',
        redirect: (BuildContext context, GoRouterState state) async {
          debugPrint(state.path.toString());

          bool loggingIn = (state.path == "/login");
          // debugPrint(loggingIn.toString());
          Box box = await Hive.openBox('user');

          isLoggedIn = box.get('isLoggedIn') ?? false;
          firstTime = box.get('firsttime') ?? true;

          // debugPrint(isLoggedIn.toString() + "Fff");
          // debugPrint(firstTime.toString() + "Fff");
          return loggingIn ? '/login' : null;
        },
        builder: ((BuildContext context, GoRouterState state) {
          return firstTime
              ? Landing()
              : isLoggedIn
              ? NavHome()
              : Landing();
        }),
        routes: <RouteBase>[
          GoRoute(
            path: 'createaccount',
            builder: (BuildContext context, GoRouterState state) {
              return CreateAccount();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return Login();
            },
          ),
          GoRoute(
            path: 'contentinterest',
            builder: (BuildContext context, GoRouterState state) {
              return ContentInterest();
            },
          ),

          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return NavHome();
            },
          ),
          GoRoute(
            path: 'welcome',
            builder: (BuildContext context, GoRouterState state) {
              return Welcome();
            },
          ),
        ],
      ),
    ],
  );
}
