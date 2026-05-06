

import 'dart:convert';

RegisteredCount userObjectFromJson(String str) => RegisteredCount.fromJson(json.decode(str));

String userObjectToJson(RegisteredCount data) => json.encode(data.toJson());


class RegisteredCount {
  final int count;

  RegisteredCount({required this.count});

  // Factory constructor to create an instance from JSON
  factory RegisteredCount.fromJson(Map<String, dynamic> json) {
    // Extract the count value and handle it if it's a string
    dynamic countValue = json['registered_count']['count'];
    return RegisteredCount(
      count: int.tryParse(countValue.toString()) ?? 0, // Safely convert to int
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'registered_count': {'count': count},
    };
  }
}