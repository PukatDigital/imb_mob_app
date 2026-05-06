import 'dart:convert';

// Function to parse the response
RegisteredCustomersHistory registeredCustomersFromJson(String str) => RegisteredCustomersHistory.fromJson(json.decode(str));

// Function to convert model to JSON
String registeredCustomersToJson(RegisteredCustomersHistory data) => json.encode(data.toJson());

class RegisteredCustomersHistory {
  final List<Customer> registeredCustomers;
  final Meta meta;

  RegisteredCustomersHistory({
    required this.registeredCustomers,
    required this.meta,
  });

  // Factory constructor to create an instance from JSON
  factory RegisteredCustomersHistory.fromJson(Map<String, dynamic> json) {
    var list = json['registered_customers']['list'] as List?;
    List<Customer> customersList = list?.map((i) => Customer.fromJson(i)).toList() ?? [];

    return RegisteredCustomersHistory(
      registeredCustomers: customersList,
      meta: Meta.fromJson(json['registered_customers']['meta'] ?? {}),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'registered_customers': {
        'list': registeredCustomers.map((e) => e.toJson()).toList(),
        'meta': meta.toJson(),
      },
    };
  }
}

class Customer {
  final String? msisdn;
  final String? iccid;
  final String? fullName;
  final String? identityType;
  final String? identityNo;
  final String? networkType;
  final String? registrationStatus;
  final String? createdAt;

  Customer({
    this.msisdn,
    this.iccid,
    this.fullName,
    this.identityType,
    this.identityNo,
    this.networkType,
    this.registrationStatus,
    this.createdAt,
  });

  // Factory constructor to create an instance from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      msisdn: json['msisdn'] as String?,
      iccid: json['iccid'] as String?,
      fullName: json['full_name'] as String?,
      identityType: json['identity_type'] as String?,
      identityNo: json['identity_no'] as String?,
      networkType: json['network_type'] as String?,
      registrationStatus: json['registration_status'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'msisdn': msisdn,
      'iccid': iccid,
      'full_name': fullName,
      'identity_type': identityType,
      'identity_no': identityNo,
      'network_type': networkType,
      'registration_status': registrationStatus,
      'created_at': createdAt,
    };
  }
}

class Meta {
  final String? firstPageUrl;
  final int? from;
  final String? nextPageUrl;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final String? prevPageUrl;
  final int? lastPage;
  final String? lastPageUrl;
  final int? to;

  Meta({
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.total,
    this.perPage,
    this.currentPage,
    this.prevPageUrl,
    this.lastPage,
    this.lastPageUrl,
    this.to,
  });

  // Factory constructor to create an instance from JSON
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      nextPageUrl: json['next_page_url'] as String?,
      total: json['total'] as int?,
      perPage: json['per_page'] as int?,
      currentPage: json['current_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      to: json['to'] as int?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_page_url': firstPageUrl,
      'from': from,
      'next_page_url': nextPageUrl,
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'prev_page_url': prevPageUrl,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'to': to,
    };
  }
}
