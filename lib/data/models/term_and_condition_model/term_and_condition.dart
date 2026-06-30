class TermsAndConditions {
  String? type;
  bool? success;
  String? message;
  Data? data;

  TermsAndConditions({this.type, this.success, this.message, this.data});

  TermsAndConditions.fromJson(Map<String, dynamic> json) {
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
  String? termsAndConditions;

  Data({this.termsAndConditions});

  Data.fromJson(Map<String, dynamic> json) {
    termsAndConditions = json['terms_and_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['terms_and_conditions'] = termsAndConditions;
    return data;
  }
}
