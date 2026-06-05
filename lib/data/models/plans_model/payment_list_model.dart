class PaymentListModel {
  String? type;
  bool? success;
  String? message;
  List<PaymentData>? data;

  PaymentListModel({
    this.type,
    this.success,
    this.message,
    this.data,
  });

  PaymentListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];

    if (json['data'] != null) {
      data = <PaymentData>[];
      json['data'].forEach((v) {
        data!.add(PaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};

    dataMap['type'] = type;
    dataMap['success'] = success;
    dataMap['message'] = message;

    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }

    return dataMap;
  }
}

class PaymentData {
  String? name;
  String? paymentMethod;
  String? attachment;
  String? creation;
  String? plan;
  String? status;
  String? remarks;

  PaymentData({
    this.name,
    this.paymentMethod,
    this.attachment,
    this.creation,
    this.plan,
    this.status,
    this.remarks,
  });

  PaymentData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    paymentMethod = json['payment_method'];
    attachment = json['attachment'];
    creation = json['creation'];
    plan = json['plan'];
    status = json['status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['name'] = name;
    data['payment_method'] = paymentMethod;
    data['attachment'] = attachment;
    data['creation'] = creation;
    data['plan'] = plan;
    data['status'] = status;
    data['remarks'] = status;

    return data;
  }
}