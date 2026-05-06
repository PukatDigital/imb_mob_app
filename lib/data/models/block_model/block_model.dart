class BlockedProfileModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  BlockedProfileModel({this.type, this.success, this.message, this.data});

  BlockedProfileModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? profileId;
  String? userId;
  String? profileName;
  List<BlockedProfiles>? blockedProfiles;
  int? totalBlockedProfiles;
  int? noOfTimesGetBlocked;

  Data(
      {this.profileId,
        this.userId,
        this.profileName,
        this.blockedProfiles,
        this.totalBlockedProfiles,
        this.noOfTimesGetBlocked});

  Data.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    if (json['blocked_profiles'] != null) {
      blockedProfiles = <BlockedProfiles>[];
      json['blocked_profiles'].forEach((v) {
        blockedProfiles!.add(new BlockedProfiles.fromJson(v));
      });
    }
    totalBlockedProfiles = json['total_blocked_profiles'];
    noOfTimesGetBlocked = json['no_of_times_get_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    if (this.blockedProfiles != null) {
      data['blocked_profiles'] =
          this.blockedProfiles!.map((v) => v.toJson()).toList();
    }
    data['total_blocked_profiles'] = this.totalBlockedProfiles;
    data['no_of_times_get_blocked'] = this.noOfTimesGetBlocked;
    return data;
  }
}

class BlockedProfiles {
  String? profileId;
  String? userId;
  String? profileName;
  String? profilePicture;
  String? reason;

  BlockedProfiles(
      {this.profileId,
        this.userId,
        this.profileName,
        this.profilePicture,
        this.reason});

  BlockedProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    profilePicture = json['profile_picture'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    data['profile_picture'] = this.profilePicture;
    data['reason'] = this.reason;
    return data;
  }
}
