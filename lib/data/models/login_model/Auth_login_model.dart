class LoginModel {
  String? message;
  String? homePage;
  String? fullName;
  Data? data;

  LoginModel({this.message, this.homePage, this.fullName, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    homePage = json['home_page'];
    fullName = json['full_name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['home_page'] = homePage;
    data['full_name'] = fullName;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? success;
  String? message;
  String? sessionId;
  User? user;

  Data({this.success, this.message, this.sessionId, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    sessionId = json['session_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['session_id'] = sessionId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? fullName;
  List<String>? roles;
  String? apiKey;
  String? apiSecret;

  User(
      {this.name,
        this.email,
        this.fullName,
        this.roles,
        this.apiKey,
        this.apiSecret});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    fullName = json['full_name'];
    roles = json['roles'].cast<String>();
    apiKey = json['api_key'];
    apiSecret = json['api_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['full_name'] = fullName;
    data['roles'] = roles;
    data['api_key'] = apiKey;
    data['api_secret'] = apiSecret;
    return data;
  }
}
