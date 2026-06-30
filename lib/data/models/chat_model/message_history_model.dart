class MessageHistoryModel {
  bool? success;
  List<Data>? data;
  Meta? meta;

  MessageHistoryModel({this.success, this.data, this.meta});

  MessageHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? senderId;
  int? receiverId;
  String? message;
  String? createdAt;
  int? isRead;

  Data(
      {this.id,
        this.senderId,
        this.receiverId,
        this.message,
        this.createdAt,
        this.isRead});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['is_read'] = isRead;
    return data;
  }
}

class Meta {
  bool? hasMore;

  Meta({this.hasMore});

  Meta.fromJson(Map<String, dynamic> json) {
    hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['has_more'] = hasMore;
    return data;
  }
}
