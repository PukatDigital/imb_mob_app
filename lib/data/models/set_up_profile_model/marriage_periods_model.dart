class MarriagePeriodsModel {
  Data? data;
  String? type;

  MarriagePeriodsModel({this.data, this.type});

  MarriagePeriodsModel.fromJson(Map<String, dynamic> json) {
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
  List<MarriagePeriods>? marriagePeriods;

  Data({this.success, this.message, this.marriagePeriods});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['marriage_periods'] != null) {
      marriagePeriods = <MarriagePeriods>[];
      json['marriage_periods'].forEach((v) {
        marriagePeriods!.add(MarriagePeriods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (marriagePeriods != null) {
      data['marriage_periods'] =
          marriagePeriods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarriagePeriods {
  String? name;

  MarriagePeriods({this.name});

  MarriagePeriods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
