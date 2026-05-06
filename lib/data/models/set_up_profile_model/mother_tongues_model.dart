class MotherTonguesModel {
  Data? data;
  String? type;

  MotherTonguesModel({this.data, this.type});

  MotherTonguesModel.fromJson(Map<String, dynamic> json) {
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
  List<MotherTongues>? motherTongues;

  Data({this.success, this.message, this.motherTongues});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['mother_tongues'] != null) {
      motherTongues = <MotherTongues>[];
      json['mother_tongues'].forEach((v) {
        motherTongues!.add(MotherTongues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (motherTongues != null) {
      data['mother_tongues'] =
          motherTongues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotherTongues {
  String? name;

  MotherTongues({this.name});

  MotherTongues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
