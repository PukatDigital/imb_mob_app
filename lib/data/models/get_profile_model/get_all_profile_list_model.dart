class GetProfileModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  GetProfileModel({this.type, this.success, this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  List<Profiles>? profiles;

  Data({this.profileCompleted, this.profiles});

  Data.fromJson(Map<String, dynamic> json) {
    profileCompleted = json['profile_completed'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_completed'] = this.profileCompleted;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  String? profileId;
  String? userId;
  String? profileName;
  String? dateOfBirth;
  String? location;
  String? profilePicture;
  Attachments? attachments;
  int? profileCompleted;
  bool? isFavourite;
  bool? isBlocked;
  int? noOfTimesAddedAsFavourite;
  int? noOfTimesGetBlocked;

  Profiles(
      {this.profileId,
        this.userId,
        this.profileName,
        this.dateOfBirth,
        this.location,
        this.profilePicture,
        this.attachments,
        this.profileCompleted,
        this.isFavourite,
        this.isBlocked,
        this.noOfTimesAddedAsFavourite,
        this.noOfTimesGetBlocked});

  Profiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    dateOfBirth = json['date_of_birth'];
    location = json['location'];
    profilePicture = json['profile_picture'];
    attachments = json['attachments'] != null
        ? new Attachments.fromJson(json['attachments'])
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
    data['location'] = this.location;
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

class Attachments {
  String? attach1;
  String? attach2;
  String? attach3;
  String? attach4;

  Attachments({this.attach1, this.attach2, this.attach3, this.attach4});

  Attachments.fromJson(Map<String, dynamic> json) {
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
