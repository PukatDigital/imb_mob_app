class ImpressionListModel {
  String? type;
  bool? success;
  String? message;
  List<Data>? data;

  ImpressionListModel({this.type, this.success, this.message, this.data});

  ImpressionListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? targetProfile;
  String? targetUser;
  String? targetUserName;
  String? profilePicture;
  String? creation;

  Data(
      {this.targetProfile,
        this.targetUser,
        this.targetUserName,
        this.profilePicture,
        this.creation});

  Data.fromJson(Map<String, dynamic> json) {
    targetProfile = json['target_profile'];
    targetUser = json['target_user'];
    targetUserName = json['target_user_name'];
    profilePicture = json['profile_picture'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target_profile'] = targetProfile;
    data['target_user'] = targetUser;
    data['target_user_name'] = targetUserName;
    data['profile_picture'] = profilePicture;
    data['creation'] = creation;
    return data;
  }
}
