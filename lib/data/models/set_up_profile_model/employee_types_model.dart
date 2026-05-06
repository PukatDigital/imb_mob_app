class EmployeeTypesModel {
  Data? data;
  String? type;

  EmployeeTypesModel({this.data, this.type});

  EmployeeTypesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Data {
  bool? success;
  String? message;
  List<EmployeeTypes>? employeeTypes;

  Data({this.success, this.message, this.employeeTypes});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['employee_types'] != null) {
      employeeTypes = <EmployeeTypes>[];
      json['employee_types'].forEach((v) {
        employeeTypes!.add(EmployeeTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (employeeTypes != null) {
      data['employee_types'] =
          employeeTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeTypes {
  String? name;

  EmployeeTypes({this.name});

  EmployeeTypes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
