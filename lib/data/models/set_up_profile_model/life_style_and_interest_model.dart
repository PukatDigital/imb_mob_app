class LifeStyleModel {
  Data? data;
  String? type;

  LifeStyleModel({this.data, this.type});

  LifeStyleModel.fromJson(Map<String, dynamic> json) {
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
  List<LifeStyleAndInterest>? lifeStyleAndInterest;

  Data({this.success, this.message, this.lifeStyleAndInterest});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['life_style_and_interest'] != null) {
      lifeStyleAndInterest = <LifeStyleAndInterest>[];
      json['life_style_and_interest'].forEach((v) {
        lifeStyleAndInterest!.add(LifeStyleAndInterest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (lifeStyleAndInterest != null) {
      data['life_style_and_interest'] =
          lifeStyleAndInterest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LifeStyleAndInterest {
  String? name;

  LifeStyleAndInterest({this.name});

  LifeStyleAndInterest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
