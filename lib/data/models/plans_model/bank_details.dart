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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_title'] = this.accountTitle;
    data['account_number'] = this.accountNumber;
    data['iban_number'] = this.ibanNumber;
    data['description'] = this.description;
    return data;
  }
}
