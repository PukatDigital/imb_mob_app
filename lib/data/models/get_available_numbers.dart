import 'dart:convert';

GetAvailableNumbers userObjectFromJson(String str) => GetAvailableNumbers.fromJson(json.decode(str));

String userObjectToJson(GetAvailableNumbers data) => json.encode(data.toJson());

class GetAvailableNumbers {
  final List<Number> availableNumbers;

  GetAvailableNumbers({required this.availableNumbers});

  // Factory constructor to create an instance from JSON
  factory GetAvailableNumbers.fromJson(Map<String, dynamic> json) {
    var list = json['available_numbers'] as List;
    List<Number> availableNumbersList =
    list.map((item) => Number.fromJson(item)).toList();

    return GetAvailableNumbers(availableNumbers: availableNumbersList);
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'available_numbers': availableNumbers.map((number) => number.toJson()).toList(),
    };
  }
}
class Number {
  final String msisdn;
  final String operatorName;
  final String whiteLabelName;
  final int sellBrandProfileID;
  final String sellBrandProfileName;
  final int premiumFee;

  Number({
    required this.msisdn,
    required this.operatorName,
    required this.whiteLabelName,
    required this.sellBrandProfileID,
    required this.sellBrandProfileName,
    required this.premiumFee,
  });

  // Factory constructor to create a `Number` instance from JSON
  factory Number.fromJson(Map<String, dynamic> json) => Number(
    msisdn: json['MSISDN'],
    operatorName: json['OperatorName'],
    whiteLabelName: json['WhiteLabelName'],
    sellBrandProfileID: json['SellBrandProfileID'],
    sellBrandProfileName: json['SellBrandProfileName'],
    premiumFee: json['PremiumFee'],
  );

  // Method to convert a `Number` instance to JSON
  Map<String, dynamic> toJson() => {
    'MSISDN': msisdn,
    'OperatorName': operatorName,
    'WhiteLabelName': whiteLabelName,
    'SellBrandProfileID': sellBrandProfileID,
    'SellBrandProfileName': sellBrandProfileName,
    'PremiumFee': premiumFee,
  };

  @override
  String toString() {
    return 'Number(msisdn: $msisdn, operatorName: $operatorName, whiteLabelName: $whiteLabelName, sellBrandProfileID: $sellBrandProfileID, sellBrandProfileName: $sellBrandProfileName, premiumFee: $premiumFee)';
  }
}