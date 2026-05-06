import 'dart:convert';

// Convert JSON string to UserRegistration object
UserRegistration userRegistrationFromJson(String str) =>
    UserRegistration.fromJson(json.decode(str));

// Convert UserRegistration object to JSON string
String userRegistrationToJson(UserRegistration data) =>
    json.encode(data.toJson());

class UserRegistration {
  final String networkType;
  final String msisdn;
  final String fullName;
  final String firstName;
  String? address1;
  String? address2;
  final String postalCode;
  final String city;
  final String state;
  final String identityType;
  final String identityNo;
  String? email;
  final String? planInfo;
  final String iccid;
  final List<String>? allowedNetworks;
  final String? foreignerType;
  final String? issuanceCountry;
  final DateTime? dateOfBirth;
  final String? altMobileNo;
  final String? stayAddress1;
  final String? stayAddress2;
  final String? stayCity;
  final String? stayState;
  final String? stayPostCode;
  final String? uguRefCode;
  final String? instName;
  final String? instAddress1;
  final String? instAddress2;
  final String? instCity;
  final String? instState;
  final String? instPostCode;
  final String? instRefNo;
  final String? empName;
  final String? empAddress1;
  final String? empAddress2;
  final String? empCity;
  final String? empState;
  final String? empPostCode;
  final String? empRefNo;
  final String? hotelName;
  final String? mykadFront;
  final String? mykadBack;
  final String? passport;

  UserRegistration({
    required this.networkType,
    required this.msisdn,
    required this.fullName,
    required this.firstName,
    this.address1,
    this.address2,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.identityType,
    required this.identityNo,
    this.email,
    this.planInfo,
    required this.iccid,
    this.allowedNetworks,
    this.foreignerType,
    this.issuanceCountry,
    this.dateOfBirth,
    this.altMobileNo,
    this.stayAddress1,
    this.stayAddress2,
    this.stayCity,
    this.stayState,
    this.stayPostCode,
    this.uguRefCode,
    this.instName,
    this.instAddress1,
    this.instAddress2,
    this.instCity,
    this.instState,
    this.instPostCode,
    this.instRefNo,
    this.empName,
    this.empAddress1,
    this.empAddress2,
    this.empCity,
    this.empState,
    this.empPostCode,
    this.empRefNo,
    this.hotelName,
    this.mykadFront,
    this.mykadBack,
    this.passport,
  });

  // Factory constructor to create a UserRegistration object from JSON
  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      networkType: json['network_type'],
      msisdn: json['msisdn'],
      fullName: json['full_name'],
      firstName: json['first_name'],
      address1: json['address1'],
      address2: json['address2'],
      postalCode: json['postal_code'],
      city: json['city'],
      state: json['state'],
      identityType: json['identity_type'],
      identityNo: json['identity_no'],
      email: json['email'],
      planInfo: json['plan_info'],
      iccid: json['iccid'],
      allowedNetworks: json['allowed_networks'] != null
          ? List<String>.from(json['allowed_networks'])
          : null,
      foreignerType: json['foreigner_type'],
      issuanceCountry: json['issuance_country'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      altMobileNo: json['alt_mobile_no'],
      stayAddress1: json['stay_address_1'],
      stayAddress2: json['stay_address_2'],
      stayCity: json['stay_city'],
      stayState: json['stay_state'],
      stayPostCode: json['stay_postal_code'],
      uguRefCode: json['ugu_ref_code'],
      instName: json['institute_name'],
      instAddress1: json['institute_address_1'],
      instAddress2: json['institute_address_2'],
      instCity: json['institute_city'],
      instState: json['institute_state'],
      instPostCode: json['institute_postal_code'],
      instRefNo: json['institute_ref_no'],
      empName: json['employer_name'],
      empAddress1: json['employer_address_1'],
      empAddress2: json['employer_address_2'],
      empCity: json['employer_city'],
      empState: json['employer_state'],
      empPostCode: json['employer_postal_code'],
      empRefNo: json['employer_ref_no'],
      hotelName: json['hotel_name'],
      mykadFront: json['mykad_front'],
      mykadBack: json['mykad_back'],
      passport: json['passport'],
    );
  }

  // Convert UserRegistration object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'network_type': networkType,
      'msisdn': msisdn,
      'full_name': fullName,
      'first_name': firstName,
      'postal_code': postalCode,
      'city': city,
      'state': state,
      'identity_type': identityType,
      'identity_no': identityNo,
      'iccid': iccid,
      'foreigner_type': foreignerType,
      'issuance_country': issuanceCountry,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'alt_mobile_no': altMobileNo,
      'stay_address_1': stayAddress1,
      'stay_address_2': stayAddress2,
      'stay_city': stayCity,
      'stay_state': stayState,
      'stay_postal_code': stayPostCode,
      'ugu_ref_code': uguRefCode,
      'institute_name': instName,
      'institute_address_1': instAddress1,
      'institute_address_2': instAddress2,
      'institute_city': instCity,
      'institute_state': instState,
      'institute_postal_code': instPostCode,
      'institute_ref_no': instRefNo,
      'employer_name': empName,
      'employer_address_1': empAddress1,
      'employer_address_2': empAddress2,
      'employer_city': empCity,
      'employer_state': empState,
      'employer_postal_code': empPostCode,
      'employer_ref_no': empRefNo,
      'hotel_name': hotelName,
      'mykad_front': mykadFront,
      'mykad_back': mykadBack,
      'passport': passport,
    };

    // Add optional fields if they are not null
    if (address1 != null) data['address1'] = address1;
    if (address2 != null) data['address2'] = address2;
    if (email != null) data['email'] = email;

    return data;
  }
}
