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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_profile'] = this.targetProfile;
    data['target_user'] = this.targetUser;
    data['target_user_name'] = this.targetUserName;
    data['profile_picture'] = this.profilePicture;
    data['creation'] = this.creation;
    return data;
  }
}
