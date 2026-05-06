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
        favouriteProfiles!.add(new FavouriteProfiles.fromJson(v));
      });
    }
    totalFavouriteProfiles = json['total_favourite_profiles'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    if (this.favouriteProfiles != null) {
      data['favourite_profiles'] =
          this.favouriteProfiles!.map((v) => v.toJson()).toList();
    }
    data['total_favourite_profiles'] = this.totalFavouriteProfiles;
    data['no_of_times_added_as_favourite'] = this.noOfTimesAddedAsFavourite;
    return data;
  }
}

class FavouriteProfiles {
  String? profileId;
  String? userId;
  String? profileName;
  String? profilePicture;
  String? addedOn;

  FavouriteProfiles(
      {this.profileId,
        this.userId,
        this.profileName,
        this.profilePicture,
        this.addedOn});

  FavouriteProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    profilePicture = json['profile_picture'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    data['profile_picture'] = this.profilePicture;
    data['added_on'] = this.addedOn;
    return data;
  }
}
