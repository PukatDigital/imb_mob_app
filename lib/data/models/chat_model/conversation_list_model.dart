class ConversationListModel {
  bool? success;
  List<Data>? data;

  ConversationListModel({this.success, this.data});

  ConversationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? frappeUser;
  String? fullName;
  Null avatarUrl;
  int? isOnline;
  String? lastSeen;
  String? lastMessage;
  String? lastMessageType;
  String? lastMessageTime;
  String? lastMessageSender;
  int? unreadCount;

  Data(
      {this.id,
        this.userId,
        this.frappeUser,
        this.fullName,
        this.avatarUrl,
        this.isOnline,
        this.lastSeen,
        this.lastMessage,
        this.lastMessageType,
        this.lastMessageTime,
        this.lastMessageSender,
        this.unreadCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    frappeUser = json['frappe_user'];
    fullName = json['full_name'];
    avatarUrl = json['avatar_url'];
    isOnline = json['is_online'];
    lastSeen = json['last_seen'];
    lastMessage = json['last_message'];
    lastMessageType = json['last_message_type'];
    lastMessageTime = json['last_message_time'];
    lastMessageSender = json['last_message_sender'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['frappe_user'] = frappeUser;
    data['full_name'] = fullName;
    data['avatar_url'] = avatarUrl;
    data['is_online'] = isOnline;
    data['last_seen'] = lastSeen;
    data['last_message'] = lastMessage;
    data['last_message_type'] = lastMessageType;
    data['last_message_time'] = lastMessageTime;
    data['last_message_sender'] = lastMessageSender;
    data['unread_count'] = unreadCount;
    return data;
  }
}
