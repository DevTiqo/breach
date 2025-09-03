import 'package:breach/notifiers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider((ref) => WebSocket(ref));

class WebSocket {
  late ProviderRef ref;

  WebSocket(this.ref);

  IO.Socket? channel;

  Future<bool> connect() async {
    try {
      // Dart client
      channel = IO.io(
        ref.read(appConfigNotifierProvider)!.apiGateway.socketUrl,
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        },
      );
      channel!.connect();

      channel!.onConnect((_) {
        print('connect');
      });

      channel!.onDisconnect((_) => print('disconnect'));

      return channel!.connected;
    } catch (e) {
      print(e);
      print("eeeseseseseseseses");
      return false;
    }
  }

  create({required String roomID}) async {
    if (channel == null) {
      await connect();
      channel!.emit(
        "create",
        '{"meta":"create","roomID":"$roomID","clientID":"clientID2","message":"create"}',
      );
    }
    channel!.emit(
      "",
      '{"meta":"create","roomID":"$roomID","clientID":"clientID2","message":"create"}',
    );
  }

  join({
    required String userID,
    required String roomID,
    List<int> allOtherUserIds = const [],
  }) async {
    if (channel == null) {
      await connect();
      channel!.emit("subscribe", {roomID, userID, allOtherUserIds});
    }
    channel!.emit("subscribe", {roomID, userID, allOtherUserIds});
  }

  leave({required String roomID}) async {
    if (channel == null) {
      await connect();
      channel!.emit("unsubscribe", roomID);
    }
    channel!.emit("unsubscribe", roomID);
  }

  close() async {
    if (channel == null) {
      await connect();
      await channel?.disconnect();
    }

    await channel?.disconnect();
    channel?.clearListeners();
    channel = null;
  }

  sendBroadcast({required String roomID, required String message}) async {
    if (channel == null) {
      await connect();
      channel!.emit("sendbroadcast", {roomID, message});
    }
    channel!.emit("sendbroadcast", {roomID, message});
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }
}
