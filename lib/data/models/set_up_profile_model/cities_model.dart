class CitiesModel {
  Data? data;
  String? type;

  CitiesModel({this.data, this.type});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Data {
  bool? success;
  String? message;
  List<Ethnicities>? ethnicities;

  Data({this.success, this.message, this.ethnicities});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['ethnicities'] != null) {
      ethnicities = <Ethnicities>[];
      json['ethnicities'].forEach((v) {
        ethnicities!.add(new Ethnicities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.ethnicities != null) {
      data['ethnicities'] = this.ethnicities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ethnicities {
  String? name;

  Ethnicities({this.name});

  Ethnicities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
