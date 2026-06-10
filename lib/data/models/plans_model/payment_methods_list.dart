class PaymentMethodsList {
  String? type;
  bool? success;
  String? message;
  List<Data>? data;

  PaymentMethodsList({this.type, this.success, this.message, this.data});

  PaymentMethodsList.fromJson(Map<String, dynamic> json) {
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
  String? paymentMethod;
  String? bankIcon;
  String? description;

  Data({this.name, this.paymentMethod, this.bankIcon, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    paymentMethod = json['payment_method'];
    bankIcon = json['bank_icon'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['payment_method'] = this.paymentMethod;
    data['bank_icon'] = this.bankIcon;
    data['description'] = this.description;
    return data;
  }
}
