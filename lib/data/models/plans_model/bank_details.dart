class BankDetailsModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  BankDetailsModel({this.type, this.success, this.message, this.data});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accountTitle;
  int? accountNumber;
  String? ibanNumber;
  String? description;

  Data(
      {this.accountTitle,
        this.accountNumber,
        this.ibanNumber,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    accountTitle = json['account_title'];
    accountNumber = json['account_number'];
    ibanNumber = json['iban_number'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_title'] = accountTitle;
    data['account_number'] = accountNumber;
    data['iban_number'] = ibanNumber;
    data['description'] = description;
    return data;
  }
}
