class FuturePlansModel {
  Data? data;
  String? type;

  FuturePlansModel({this.data, this.type});

  FuturePlansModel.fromJson(Map<String, dynamic> json) {
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
  List<FuturePlans>? futurePlans;

  Data({this.success, this.message, this.futurePlans});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['future_plans'] != null) {
      futurePlans = <FuturePlans>[];
      json['future_plans'].forEach((v) {
        futurePlans!.add(FuturePlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (futurePlans != null) {
      data['future_plans'] = futurePlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FuturePlans {
  String? name;

  FuturePlans({this.name});

  FuturePlans.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
