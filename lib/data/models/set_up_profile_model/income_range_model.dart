class IncomeRangesModel {
  Data? data;
  String? type;

  IncomeRangesModel({this.data, this.type});

  IncomeRangesModel.fromJson(Map<String, dynamic> json) {
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
  List<IncomeRanges>? incomeRanges;

  Data({this.success, this.message, this.incomeRanges});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['income_ranges'] != null) {
      incomeRanges = <IncomeRanges>[];
      json['income_ranges'].forEach((v) {
        incomeRanges!.add(IncomeRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (incomeRanges != null) {
      data['income_ranges'] =
          incomeRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IncomeRanges {
  String? name;

  IncomeRanges({this.name});

  IncomeRanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
