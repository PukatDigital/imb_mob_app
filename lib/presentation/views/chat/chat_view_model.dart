import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/chat_model/conversation_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/chat_model/message_history_model.dart'
as msg;

import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
import '../../../application/network/socket/socket_services.dart';

class ChatViewModel extends BaseViewModel {
  ConversationListModel conversationListModel = ConversationListModel();
  msg.MessageHistoryModel messageHistoryModel = msg.MessageHistoryModel();
  int _page = 1;
  final int _limit = 20;
  bool hasMore = true;
  bool isLoadingMore = false;
  bool isSendingMessage = false;

  final SocketService _socketService = SocketService();
  int? _currentConversationId;
  int? _currentUserId;
  final List<_PendingMessage> _pendingMessages = [];

  void getConversationList(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getConversationListData();
    apiResponse.fold<ConversationListModel>(
      onSuccess: (success) {
        conversationListModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }

  Future<void> getMessageHistoryData(
      Result result, {
        required int conversationId,
        bool loadMore = false,
      }) async {
    if (loadMore) {
      if (!hasMore || isLoadingMore) return;
      isLoadingMore = true;
      _page++;
    } else {
      _page = 1;
      hasMore = true;
      apiResponse = Loading();
    }
    notifyListeners();

    final queryParams = {
      "page": _page,
      "limit": _limit,
    };

    final response = await api.getMessageHistory(conversationId, queryParams);

    response.fold<msg.MessageHistoryModel>(
      onSuccess: (res) {
        if (loadMore) {
          final combined = [...?messageHistoryModel.data, ...?res.data];
          messageHistoryModel = msg.MessageHistoryModel(
            success: res.success,
            data: combined,
            meta: res.meta,
          );
        } else {
          messageHistoryModel = res;
        }
        hasMore = res.meta?.hasMore ?? false;
        isLoadingMore = false;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        isLoadingMore = false;
        notifyListeners();
        result.onError(err);
      },
    );
  }


  void initSocket({required int conversationId, required int currentUserId}) {
    _currentConversationId = conversationId;
    _currentUserId = currentUserId;

    _socketService.connect(currentUserId);
    _socketService.joinConversation(conversationId);
    _socketService.onNewMessage(_handleIncomingSocketMessage);
  }


  void disposeSocket() {
    if (_currentConversationId != null) {
      _socketService.leaveConversation(_currentConversationId!);
    }
  }

  void _handleIncomingSocketMessage(dynamic data) {
    try {
      final incoming = msg.Data.fromJson(data as Map<String, dynamic>);

      final pendingIndex = _pendingMessages.indexWhere(
            (p) =>
        p.receiverId == incoming.receiverId &&
            p.message == incoming.message &&
            p.senderId == incoming.senderId,
      );

      if (pendingIndex != -1) {
        final pending = _pendingMessages[pendingIndex];
        final listIndex = messageHistoryModel.data
            ?.indexWhere((m) => m.id == pending.tempId) ??
            -1;
        if (listIndex != -1) {
          messageHistoryModel.data![listIndex] = incoming;
        } else {
          messageHistoryModel.data ??= [];
          messageHistoryModel.data!.add(incoming);
        }
        _pendingMessages.removeAt(pendingIndex);
      } else {
        messageHistoryModel.data ??= [];
        final alreadyExists =
        messageHistoryModel.data!.any((m) => m.id == incoming.id);
        if (!alreadyExists) {
          messageHistoryModel.data!.add(incoming);
        }
      }

      notifyListeners();
    } catch (e) {
      d("Socket message parse error: $e");
    }
  }

  void sentTextMessage(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.sentMessage(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }

  // bool isSendingMessage = false;

  Future<void> sendMessageRealtime({
    required int tempId,
    required int? senderId,
    required int? receiverId,
    required String text,
    required Result<String> result,
  })
  async {
    final payload = {
      "receiver_id": receiverId,
      "message": text,
    };

    isSendingMessage = true;
    notifyListeners();

    final response = await api.sentMessage(payload);

    isSendingMessage = false;

    response.fold<String>(
      onSuccess: (res) {
        final newMessage = msg.Data(
          id: tempId,
          senderId: senderId,
          receiverId: receiverId,
          message: text,
          createdAt: DateTime.now().toIso8601String(),
          isRead: 0,
        );

        messageHistoryModel.data ??= [];
        // messageHistoryModel.data!.add(newMessage);


        _pendingMessages.add(_PendingMessage(
          tempId: tempId,
          senderId: senderId,
          receiverId: receiverId,
          message: text,
        ));

        notifyListeners();

        // _socketService.emitMessage({
        //   "conversation_id": _currentConversationId,
        //   "sender_id": senderId,
        //   "receiver_id": receiverId,
        //   "message": text,
        // });

        result.onSuccess(res);
      },
      onError: (err) {

        notifyListeners();
        result.onError(err);
      },
    );
  }
}

class _PendingMessage {
  final int tempId;
  final int? senderId;
  final int? receiverId;
  final String message;

  _PendingMessage({
    required this.tempId,
    required this.senderId,
    required this.receiverId,
    required this.message,
  });
}

class _NoOpResult implements Result<String> {
  @override
  void onError(String error) =>
      d("sentTextMessage error: $error");

  @override
  void onSuccess(String result) {}
}