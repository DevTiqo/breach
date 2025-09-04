// import 'dart:convert';

// import 'package:breach/models/post_model.dart';
// import 'package:breach/modules/livesockets.dart';
// import 'package:breach/notifiers/providers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// WebSocket service provider
// final webSocketServiceProvider = Provider<WebSocketService>((ref) {
//   final service = WebSocketService(
//     ref,
//     ref.read(appConfigNotifierProvider)!.apiGateway.socketUrl +
//         "?token=${ref.read(authNotifierProvider).user?.token}",
//   ); // Public echo server
//   ref.onDispose(() => service.dispose());
//   return service;
// });

// /// StateNotifier to manage messages
// class WebSocketMessagesNotifier extends StateNotifier<List<Post>> {
//   WebSocketMessagesNotifier(this.ref) : super([]) {
//     _listenToMessages();
//   }

//   final Ref ref;

//   void _listenToMessages() {
//     final service = ref.read(webSocketServiceProvider);
//     service.stream.listen((event) {
//       print('Listening to Socket');
//       print(event);
//       Post newpost = Post.fromJson(jsonDecode(event) as Map<String, dynamic>);
//       state = [...state, newpost];
//     });
//   }

//   void deleteStream() {
//     final service = ref.read(webSocketServiceProvider);
//     service.dispose();
//   }
// }

// final webSocketMessagesProvider =
//     StateNotifierProvider<WebSocketMessagesNotifier, List<Post>>(
//       (ref) => WebSocketMessagesNotifier(ref),
//     );

import 'dart:async';
import 'dart:convert';
import 'package:breach/models/post_model.dart';
import 'package:breach/modules/livesockets.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// WebSocket service provider
final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final service = WebSocketService(
    ref,
    "${ref.read(appConfigNotifierProvider)!.apiGateway.socketUrl}?token=${ref.read(authNotifierProvider).user?.token}",
  ); //
  ref.onDispose(() => service.dispose());
  return service;
});

/// StateNotifier to manage messages
class WebSocketMessagesNotifier extends StateNotifier<List<Post>> {
  WebSocketMessagesNotifier(this.ref) : super([]) {
    _listenToMessages();
  }

  final Ref ref;

  void _listenToMessages() {
    final service = ref.read(webSocketServiceProvider);
    service.stream.listen((event) {
      print('Listening to Socket');
      print(event);
      Post newpost = Post.fromJson(jsonDecode(event) as Map<String, dynamic>);
      state = [...state, newpost];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final webSocketMessagesProvider =
    StateNotifierProvider<WebSocketMessagesNotifier, List<Post>>(
      (ref) => WebSocketMessagesNotifier(ref),
    );
