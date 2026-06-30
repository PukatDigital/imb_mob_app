import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../di/di.dart';

import '../../common/log.dart';

class SocketService {
  SocketService._internal();
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  IO.Socket? _socket;
  bool get isConnected => _socket?.connected ?? false;

  static const String _socketUrl = "https://chat.ideal.ssab-bms.com";

  void connect(int currentUserId) {

    if (_socket != null && _socket!.connected) return;

    final String? token = inject<IPrefHelper>().retrieveToken();

    if (token == null || token.isEmpty) {
      d("Socket connect skipped: no auth token found");
      return;
    }

    _socket = IO.io(
      _socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({"token": token})
          .setExtraHeaders({"Authorization": "Bearer $token"})
          .setQuery({"user_id": currentUserId.toString(), "token": token})
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      d("Socket connected: ${_socket!.id}");
      _socket!.emit("join", {"user_id": currentUserId});
    });

    _socket!.onDisconnect((_) => d("Socket disconnected"));
    _socket!.onConnectError((err) => d("Socket connect error: $err"));
    _socket!.onError((err) => d("Socket error: $err"));


    _socket!.onAny((event, data) {
      d("🔔 Socket event received -> name: '$event' | data: $data");
    });
  }

  void joinConversation(int conversationId) {
    _socket?.emit("join_conversation", {"conversation_id": conversationId});
  }

  void leaveConversation(int conversationId) {
    _socket?.emit("leave_conversation", {"conversation_id": conversationId});
  }

  void emitMessage(Map<String, dynamic> payload) {
    _socket?.emit("send_message", payload);
  }

  void onNewMessage(void Function(dynamic data) callback) {
    _socket?.off("new_message");
    _socket?.on("new_message", callback);
  }

  void onTyping(void Function(dynamic data) callback) {
    _socket?.off("typing");
    _socket?.on("typing", callback);
  }

  void emitTyping(int conversationId, int senderId) {
    _socket?.emit("typing", {
      "conversation_id": conversationId,
      "sender_id": senderId,
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}