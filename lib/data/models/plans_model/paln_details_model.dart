class ActivePlans {
  String? type;
  bool? success;
  String? message;
  List<Data>? data;

  ActivePlans({this.type, this.success, this.message, this.data});

  ActivePlans.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? title;
  String? planType;
  double? credits;
  int? bonus;
  int? effectivePrice;
  int? amount;
  int? boost;
  String? description;
  int? active;

  Data(
      {this.name,
        this.title,
        this.planType,
        this.bonus,
        this.effectivePrice,
        this.amount,
        this.boost,
        this.description,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    planType = json['plan_type'];
    credits = json['credits'];
    bonus = json['bonus'];
    effectivePrice = json['effective_price'];
    amount = json['amount'];
    boost = json['boost'];
    description = json['description'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['plan_type'] = planType;
    data['credits'] = credits;
    data['bonus'] = bonus;
    data['effective_price'] = effectivePrice;
    data['amount'] = amount;
    data['boost'] = boost;
    data['description'] = description;
    data['active'] = active;
    return data;
  }
}
