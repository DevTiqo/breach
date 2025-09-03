// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:breach/models/user_model.dart';
import 'package:breach/modules/auth/auth.dart';
import 'package:breach/modules/http.dart';
import 'package:breach/modules/userprefs.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

class AuthState {
  final User? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && user?.id == other.id;

  @override
  int get hashCode => user.hashCode;

  AuthState({required this.user});

  AuthState copyWith({User? user}) {
    return AuthState(user: user ?? this.user);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  Auth auth;

  AuthNotifier({required this.auth}) : super(AuthState(user: null));

  Future<bool> initializeUser(User user) async {
    state = state.copyWith(user: user);
    return true;
  }

  void setUser(User user) {
    state = state.copyWith(user: user);
  }

  void removeUser(User user) {
    state = state.copyWith(user: null);
  }

  Future<RequestResult> login(String email, String pass) async {
    RequestResult req = RequestResult(false, 400, "yet to call");

    req = await auth.login(email, pass);
    debugPrint(req.ok.toString());
    if (req.ok) {
      // reqq = req;
      debugPrint("okayy");
      User thisuser = req.data as User;

      setUser(thisuser);
      await UserPreferences().saveUser(thisuser);

      return RequestResult(true, 200, "logged in");
    } else {
      // throw (req.data['message'] ?? 'Unknown Error');
      return req;
    }
  }

  Future<RequestResult> register(String email, String pass) async {
    RequestResult req = RequestResult(false, 400, "yet to call");

    req = await auth.register(email, pass);
    debugPrint(req.data.toString());
    if (req.ok) {
      // reqq = req;
      debugPrint("okayy");
      User thisuser = req.data as User;

      setUser(thisuser);
      await UserPreferences().saveUser(thisuser);

      return RequestResult(true, 200, "logged in");
    } else {
      return req;
    }
  }

  Future<bool> logout(User user) async {
    try {
      await UserPreferences().removeUser(user);

      removeUser(user);

      debugPrint("objectkkkk");

      state = AuthState(user: null);

      return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }
}
