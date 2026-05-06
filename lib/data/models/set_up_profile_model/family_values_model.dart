class FamilyValuesModel {
  Data? data;
  String? type;

  FamilyValuesModel({this.data, this.type});

  FamilyValuesModel.fromJson(Map<String, dynamic> json) {
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
  List<FamilyValues>? familyValues;

  Data({this.success, this.message, this.familyValues});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['family_values'] != null) {
      familyValues = <FamilyValues>[];
      json['family_values'].forEach((v) {
        familyValues!.add(FamilyValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (familyValues != null) {
      data['family_values'] =
          familyValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FamilyValues {
  String? name;

  FamilyValues({this.name});

  FamilyValues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
