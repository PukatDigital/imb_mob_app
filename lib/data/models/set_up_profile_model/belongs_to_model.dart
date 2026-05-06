class BelongsToModel {
  Data? data;
  String? type;

  BelongsToModel({this.data, this.type});

  BelongsToModel.fromJson(Map<String, dynamic> json) {
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
  List<BelongsTo>? belongsTo;

  Data({this.success, this.message, this.belongsTo});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['belongs_to'] != null) {
      belongsTo = <BelongsTo>[];
      json['belongs_to'].forEach((v) {
        belongsTo!.add(BelongsTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (belongsTo != null) {
      data['belongs_to'] = belongsTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BelongsTo {
  String? name;

  BelongsTo({this.name});

  BelongsTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
