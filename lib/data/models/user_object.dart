import 'dart:convert';

UserObject userObjectFromJson(String str) => UserObject.fromJson(json.decode(str));

String userObjectToJson(UserObject data) => json.encode(data.toJson());

class UserObject {
  final String? name;
  final String? username;
  final String? idType;
  final String? idNo;
  final String? email;
  final String? phone;
  final List<String>? allowedNetworks;
  final String? token;

  UserObject({
    required this.name,
    required this.username,
    required this.idType,
    required this.idNo,
    this.email,
    this.phone,
    required this.allowedNetworks,
    required this.token,
  });

  // Factory constructor for creating a `UserInfo` object from JSON
  factory UserObject.fromJson(Map<String, dynamic> json) {
    return UserObject(
      name: json['name'],
      username: json['username'],
      idType: json['id_type'],
      idNo: json['id_no'],
      email: json['email'],
      phone: json['phone'],
      allowedNetworks: List<String>.from(json['allowed_networks']),
      token: json['token'],
    );
  }

  // Method for converting a `UserInfo` object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'id_type': idType,
      'id_no': idNo,
      'email': email,
      'phone': phone,
      'allowed_networks': allowedNetworks,
      'token': token,
    };
  }
}

