class LivingArrangementsModel {
  Data? data;
  String? type;

  LivingArrangementsModel({this.data, this.type});

  LivingArrangementsModel.fromJson(Map<String, dynamic> json) {
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
  List<LivingArrangements>? livingArrangements;

  Data({this.success, this.message, this.livingArrangements});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['living_arrangements'] != null) {
      livingArrangements = <LivingArrangements>[];
      json['living_arrangements'].forEach((v) {
        livingArrangements!.add(LivingArrangements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (livingArrangements != null) {
      data['living_arrangements'] =
          livingArrangements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LivingArrangements {
  String? name;

  LivingArrangements({this.name});

  LivingArrangements.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
