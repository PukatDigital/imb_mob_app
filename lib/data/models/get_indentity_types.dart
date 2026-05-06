
import 'dart:convert';

GetIdentityTypes userObjectFromJson(String str) => GetIdentityTypes.fromJson(json.decode(str));

String userObjectToJson(GetIdentityTypes data) => json.encode(data.toJson());

class GetIdentityTypes {
  final List<String> identityTypes;

  GetIdentityTypes({required this.identityTypes});

  // Factory constructor to create an instance from JSON
  factory GetIdentityTypes.fromJson(Map<String, dynamic> json) {
    var list = json['identity_types'] as List;
    List<String> identityTypesList = List<String>.from(list);

    return GetIdentityTypes(identityTypes: identityTypesList);
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'identity_types': identityTypes,
    };
  }
}
