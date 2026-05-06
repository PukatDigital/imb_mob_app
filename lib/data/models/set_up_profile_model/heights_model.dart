class HeightsModel {
  Data? data;
  String? type;

  HeightsModel({this.data, this.type});

  HeightsModel.fromJson(Map<String, dynamic> json) {
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
  List<Heights>? heights;

  Data({this.success, this.message, this.heights});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['heights'] != null) {
      heights = <Heights>[];
      json['heights'].forEach((v) {
        heights!.add(Heights.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (heights != null) {
      data['heights'] = heights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heights {
  String? name;

  Heights({this.name});

  Heights.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
