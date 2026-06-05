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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['plan_type'] = this.planType;
    data['credits'] = this.credits;
    data['bonus'] = this.bonus;
    data['effective_price'] = this.effectivePrice;
    data['amount'] = this.amount;
    data['boost'] = this.boost;
    data['description'] = this.description;
    data['active'] = this.active;
    return data;
  }
}
