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
        profiles!.add(ExploreProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_completed'] = profileCompleted;
    data['total_profiles'] = totalProfiles;
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
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
        ? ExploreAttachments.fromJson(json['attachments'])
        : null;
    profileCompleted = json['profile_completed'];
    isFavourite = json['is_favourite'];
    isBlocked = json['is_blocked'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
    noOfTimesGetBlocked = json['no_of_times_get_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['profile_name'] = profileName;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    data['location'] = location;
    data['marital_status'] = maritalStatus;
    data['children'] = children;
    data['religion'] = religion;
    data['education'] = education;
    data['caste'] = caste;
    data['profession'] = profession;
    data['match_percentage'] = matchPercentage;
    data['profile_picture'] = profilePicture;
    if (attachments != null) {
      data['attachments'] = attachments!.toJson();
    }
    data['profile_completed'] = profileCompleted;
    data['is_favourite'] = isFavourite;
    data['is_blocked'] = isBlocked;
    data['no_of_times_added_as_favourite'] = noOfTimesAddedAsFavourite;
    data['no_of_times_get_blocked'] = noOfTimesGetBlocked;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attach_1'] = attach1;
    data['attach_2'] = attach2;
    data['attach_3'] = attach3;
    data['attach_4'] = attach4;
    return data;
  }
}
