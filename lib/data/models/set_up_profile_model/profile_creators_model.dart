class ProfileCreatorsModel {
  Data? data;
  String? type;

  ProfileCreatorsModel({this.data, this.type});

  ProfileCreatorsModel.fromJson(Map<String, dynamic> json) {
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
  List<ProfileCreators>? profileCreators;

  Data({this.success, this.message, this.profileCreators});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['profile_creators'] != null) {
      profileCreators = <ProfileCreators>[];
      json['profile_creators'].forEach((v) {
        profileCreators!.add(ProfileCreators.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (profileCreators != null) {
      data['profile_creators'] =
          profileCreators!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileCreators {
  String? name;

  ProfileCreators({this.name});

  ProfileCreators.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
