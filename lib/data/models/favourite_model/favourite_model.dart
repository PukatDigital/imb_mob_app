class FavouriteProfileModel {
  String? type;
  bool? success;
  String? message;
  Data? data;

  FavouriteProfileModel({this.type, this.success, this.message, this.data});

  FavouriteProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? profileName;
  List<FavouriteProfiles>? favouriteProfiles;
  int? totalFavouriteProfiles;
  int? noOfTimesAddedAsFavourite;

  Data(
      {this.profileId,
        this.userId,
        this.profileName,
        this.favouriteProfiles,
        this.totalFavouriteProfiles,
        this.noOfTimesAddedAsFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    if (json['favourite_profiles'] != null) {
      favouriteProfiles = <FavouriteProfiles>[];
      json['favourite_profiles'].forEach((v) {
        favouriteProfiles!.add(FavouriteProfiles.fromJson(v));
      });
    }
    totalFavouriteProfiles = json['total_favourite_profiles'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['profile_name'] = profileName;
    if (favouriteProfiles != null) {
      data['favourite_profiles'] =
          favouriteProfiles!.map((v) => v.toJson()).toList();
    }
    data['total_favourite_profiles'] = totalFavouriteProfiles;
    data['no_of_times_added_as_favourite'] = noOfTimesAddedAsFavourite;
    return data;
  }
}

class FavouriteProfiles {
  String? profileId;
  String? userId;
  String? profileName;
  String? profilePicture;
  String? dateOfBirth;
  int? age;
  String? ethnicity;
  String? addedOn;

  FavouriteProfiles(
      {this.profileId,
        this.userId,
        this.profileName,
        this.profilePicture,
        this.dateOfBirth,
        this.age,
        this.ethnicity,
        this.addedOn});

  FavouriteProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    profilePicture = json['profile_picture'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    ethnicity = json['ethnicity'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['profile_name'] = profileName;
    data['profile_picture'] = profilePicture;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    data['ethnicity'] = ethnicity;
    data['added_on'] = addedOn;
    return data;
  }
}
