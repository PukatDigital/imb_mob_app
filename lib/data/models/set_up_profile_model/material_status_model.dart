class MaterialStatusModel {
  Data? data;
  String? type;

  MaterialStatusModel({this.data, this.type});

  MaterialStatusModel.fromJson(Map<String, dynamic> json) {
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
  List<MartialStatuses>? martialStatuses;

  Data({this.success, this.message, this.martialStatuses});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['martial_statuses'] != null) {
      martialStatuses = <MartialStatuses>[];
      json['martial_statuses'].forEach((v) {
        martialStatuses!.add(MartialStatuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (martialStatuses != null) {
      data['martial_statuses'] =
          martialStatuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MartialStatuses {
  String? name;

  MartialStatuses({this.name});

  MartialStatuses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
