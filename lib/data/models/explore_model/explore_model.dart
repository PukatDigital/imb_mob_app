class ExploreDataModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  ExploreDataModel({this.type, this.success, this.message, this.data});

  ExploreDataModel.fromJson(Map<String, dynamic> json) {
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
  int? profileCompleted;
  int? totalProfiles;
  List<ExploreProfiles>? profiles;

  Data({this.profileCompleted, this.totalProfiles, this.profiles});

  Data.fromJson(Map<String, dynamic> json) {
    profileCompleted = json['profile_completed'];
    totalProfiles = json['total_profiles'];
    if (json['profiles'] != null) {
      profiles = <ExploreProfiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new ExploreProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_completed'] = this.profileCompleted;
    data['total_profiles'] = this.totalProfiles;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExploreProfiles {
  String? profileId;
  String? userId;
  String? profileName;
  String? dateOfBirth;
  int? age;
  String? location;
  String? maritalStatus;
  String? children;
  String? religion;
  String? education;
  String? caste;
  String? profession;
  double? matchPercentage;
  String? profilePicture;
  ExploreAttachments? attachments;
  int? profileCompleted;
  bool? isFavourite;
  bool? isBlocked;
  int? noOfTimesAddedAsFavourite;
  int? noOfTimesGetBlocked;

  ExploreProfiles(
      {this.profileId,
        this.userId,
        this.profileName,
        this.dateOfBirth,
        this.age,
        this.location,
        this.maritalStatus,
        this.children,
        this.religion,
        this.education,
        this.caste,
        this.profession,
        this.matchPercentage,
        this.profilePicture,
        this.attachments,
        this.profileCompleted,
        this.isFavourite,
        this.isBlocked,
        this.noOfTimesAddedAsFavourite,
        this.noOfTimesGetBlocked});

  ExploreProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    location = json['location'];
    maritalStatus = json['marital_status'];
    children = json['children'];
    religion = json['religion'];
    education = json['education'];
    caste = json['caste'];
    profession = json['profession'];
    matchPercentage = json['match_percentage'];
    profilePicture = json['profile_picture'];
    attachments = json['attachments'] != null
        ? new ExploreAttachments.fromJson(json['attachments'])
        : null;
    profileCompleted = json['profile_completed'];
    isFavourite = json['is_favourite'];
    isBlocked = json['is_blocked'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
    noOfTimesGetBlocked = json['no_of_times_get_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    data['date_of_birth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['location'] = this.location;
    data['marital_status'] = this.maritalStatus;
    data['children'] = this.children;
    data['religion'] = this.religion;
    data['education'] = this.education;
    data['caste'] = this.caste;
    data['profession'] = this.profession;
    data['match_percentage'] = this.matchPercentage;
    data['profile_picture'] = this.profilePicture;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.toJson();
    }
    data['profile_completed'] = this.profileCompleted;
    data['is_favourite'] = this.isFavourite;
    data['is_blocked'] = this.isBlocked;
    data['no_of_times_added_as_favourite'] = this.noOfTimesAddedAsFavourite;
    data['no_of_times_get_blocked'] = this.noOfTimesGetBlocked;
    return data;
  }
}

class ExploreAttachments {
  String? attach1;
  String? attach2;
  String? attach3;
  String? attach4;

  ExploreAttachments({this.attach1, this.attach2, this.attach3, this.attach4});

  ExploreAttachments.fromJson(Map<String, dynamic> json) {
    attach1 = json['attach_1'];
    attach2 = json['attach_2'];
    attach3 = json['attach_3'];
    attach4 = json['attach_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attach_1'] = this.attach1;
    data['attach_2'] = this.attach2;
    data['attach_3'] = this.attach3;
    data['attach_4'] = this.attach4;
    return data;
  }
}
