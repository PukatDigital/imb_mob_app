class ReligiousPracticesModel {
  Data? data;
  String? type;

  ReligiousPracticesModel({this.data, this.type});

  ReligiousPracticesModel.fromJson(Map<String, dynamic> json) {
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
  List<ReligiousPractices>? religiousPractices;

  Data({this.success, this.message, this.religiousPractices});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['religious_practices'] != null) {
      religiousPractices = <ReligiousPractices>[];
      json['religious_practices'].forEach((v) {
        religiousPractices!.add(ReligiousPractices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (religiousPractices != null) {
      data['religious_practices'] =
          religiousPractices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReligiousPractices {
  String? name;

  ReligiousPractices({this.name});

  ReligiousPractices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
