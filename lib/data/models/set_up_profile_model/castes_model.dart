class CastesModel {
  Data? data;
  String? type;

  CastesModel({this.data, this.type});

  CastesModel.fromJson(Map<String, dynamic> json) {
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
  List<Castes>? castes;

  Data({this.success, this.message, this.castes});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['castes'] != null) {
      castes = <Castes>[];
      json['castes'].forEach((v) {
        castes!.add(Castes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (castes != null) {
      data['castes'] = castes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Castes {
  String? name;

  Castes({this.name});

  Castes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
