class ChattingPeriodsModel {
  Data? data;
  String? type;

  ChattingPeriodsModel({this.data, this.type});

  ChattingPeriodsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Data {
  bool? success;
  String? message;
  List<ChattingPeriods>? chattingPeriods;

  Data({this.success, this.message, this.chattingPeriods});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['chatting_periods'] != null) {
      chattingPeriods = <ChattingPeriods>[];
      json['chatting_periods'].forEach((v) {
        chattingPeriods!.add(ChattingPeriods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (chattingPeriods != null) {
      data['chatting_periods'] =
          chattingPeriods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChattingPeriods {
  String? name;

  ChattingPeriods({this.name});

  ChattingPeriods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
