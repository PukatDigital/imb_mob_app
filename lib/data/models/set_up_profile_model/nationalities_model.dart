class NationalitiesModel {
  Data? data;
  String? type;

  NationalitiesModel({this.data, this.type});

  NationalitiesModel.fromJson(Map<String, dynamic> json) {
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
  List<Nationalities>? nationalities;

  Data({this.success, this.message, this.nationalities});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['nationalities'] != null) {
      nationalities = <Nationalities>[];
      json['nationalities'].forEach((v) {
        nationalities!.add(Nationalities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (nationalities != null) {
      data['nationalities'] =
          nationalities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nationalities {
  String? name;

  Nationalities({this.name});

  Nationalities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
