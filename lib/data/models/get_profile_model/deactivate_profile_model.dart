class DeactivateProfileModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  DeactivateProfileModel({this.type, this.success, this.message, this.data});

  DeactivateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? profileId;
  int? profileDeactive;

  Data({this.profileId, this.profileDeactive});

  Data.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    profileDeactive = json['profile_deactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['profile_deactive'] = profileDeactive;
    return data;
  }
}
