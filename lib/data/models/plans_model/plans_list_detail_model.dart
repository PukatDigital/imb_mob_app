class PlansListDetailsModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  PlansListDetailsModel({this.type, this.success, this.message, this.data});

  PlansListDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    final rawData = json['data'];
    data = (rawData is Map<String, dynamic>) ? Data.fromJson(rawData) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? title;
  String? planType;
  int? bonus;
  int? effectivePrice;
  int? amount;
  int? boost;
  String? description;
  int? active;

  Data({
    this.name,
    this.title,
    this.planType,
    this.bonus,
    this.effectivePrice,
    this.amount,
    this.boost,
    this.description,
    this.active,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    planType = json['plan_type'];
    bonus = json['bonus'];
    effectivePrice = json['effective_price'];
    amount = json['amount'];
    boost = json['boost'];
    description = json['description'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['plan_type'] = this.planType;
    data['bonus'] = this.bonus;
    data['effective_price'] = this.effectivePrice;
    data['amount'] = this.amount;
    data['boost'] = this.boost;
    data['description'] = this.description;
    data['active'] = this.active;
    return data;
  }
}