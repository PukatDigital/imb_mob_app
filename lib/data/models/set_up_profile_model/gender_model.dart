class GenderModel {
  Data? data;
  String? type;

  GenderModel({this.data, this.type});

  GenderModel.fromJson(Map<String, dynamic> json) {
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
  List<Genders>? genders;

  Data({this.success, this.message, this.genders});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['genders'] != null) {
      genders = <Genders>[];
      json['genders'].forEach((v) {
        genders!.add(Genders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (genders != null) {
      data['genders'] = genders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genders {
  String? name;

  Genders({this.name});

  Genders.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
