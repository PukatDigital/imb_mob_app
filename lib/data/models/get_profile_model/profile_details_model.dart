class ProfileDetailsModel {
  String? type;
  bool? success;
  String? message;
  ProfileData? data;

  ProfileDetailsModel({this.type, this.success, this.message, this.data});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  String? profileId;
  String? userId;
  String? profileName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? dateOfBirth;
  int? profileCompleted;
  String? caste;
  String? gender;
  String? religion;
  String? nationality;
  String? belongsTo;
  String? weight;
  String? materialStatus;
  String? ethnicity;
  String? hight;
  String? motherTongue;
  String? country;
  String? religiousPractice;
  String? zodiacSign;
  String? haveChildern;
  String? livingArrangement;
  String? chattingPeriod;
  String? employer;
  String? houseSize;
  String? drinkAlcohol;
  String? canMoveAbroadForMarriage;
  String? areaSociety;
  String? fatherName;
  String? familyValues;
  String? married;
  String? unmarried;
  String? fatherOccupation;
  String? otherFamilyDetails;
  String? qualification;
  String? profession;
  String? employeeType;
  String? jobTitle;
  String? incomeRange;
  String? business;
  String? nameInstitution;
  String? businessText;
  String? futurePlan;
  String? smoke;
  String? familyInvolvement;
  String? halalFood;
  String? forBoy;
  String? marriagePeriod;
  String? forGirl;
  String? lifePartner;
  String? createrProfile;
  String? enableNotification;
  String? bio;
  String? marriageIntension;
  String? profilePicture;
  Attachments? attachments;
  List<FavouriteProfiles>? favouriteProfiles;
  List<BlockedProfiles>? blockedProfiles;
  List<LifeStyleAndInterest>? lifeStyleAndInterest;
  int? totalFavouriteProfiles;
  int? totalBlockedProfiles;
  int? noOfTimesAddedAsFavourite;
  int? noOfTimesGetBlocked;

  ProfileData({
    this.profileId,
    this.userId,
    this.profileName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.dateOfBirth,
    this.profileCompleted,
    this.caste,
    this.gender,
    this.religion,
    this.nationality,
    this.belongsTo,
    this.weight,
    this.materialStatus,
    this.ethnicity,
    this.hight,
    this.motherTongue,
    this.country,
    this.religiousPractice,
    this.zodiacSign,
    this.haveChildern,
    this.livingArrangement,
    this.chattingPeriod,
    this.employer,
    this.houseSize,
    this.drinkAlcohol,
    this.canMoveAbroadForMarriage,
    this.areaSociety,
    this.fatherName,
    this.familyValues,
    this.married,
    this.unmarried,
    this.fatherOccupation,
    this.otherFamilyDetails,
    this.qualification,
    this.profession,
    this.employeeType,
    this.jobTitle,
    this.incomeRange,
    this.business,
    this.nameInstitution,
    this.businessText,
    this.futurePlan,
    this.smoke,
    this.familyInvolvement,
    this.halalFood,
    this.forBoy,
    this.marriagePeriod,
    this.forGirl,
    this.lifePartner,
    this.createrProfile,
    this.enableNotification,
    this.bio,
    this.marriageIntension,
    this.profilePicture,
    this.attachments,
    this.favouriteProfiles,
    this.blockedProfiles,
    this.lifeStyleAndInterest,
    this.totalFavouriteProfiles,
    this.totalBlockedProfiles,
    this.noOfTimesAddedAsFavourite,
    this.noOfTimesGetBlocked,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    profileName = json['profile_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    dateOfBirth = json['date_of_birth'];
    profileCompleted = json['profile_completed'];
    caste = json['caste'];
    gender = json['gender'];
    religion = json['religion'];
    nationality = json['nationality'];
    belongsTo = json['belongs_to'];
    weight = json['weight'];
    materialStatus = json['material_status'];
    ethnicity = json['ethnicity'];
    hight = json['hight'];
    motherTongue = json['mother_tongue'];
    country = json['country'];
    religiousPractice = json['religious_practice'];
    zodiacSign = json['zodiac_sign'];
    haveChildern = json['have_childern'];
    livingArrangement = json['living_arrangement'];
    chattingPeriod = json['chatting_period'];
    employer = json['employer'];
    houseSize = json['house_size'];
    drinkAlcohol = json['drink_alcohol'];
    canMoveAbroadForMarriage = json['can_move_abroad_for_marriage'];
    areaSociety = json['area_society'];
    fatherName = json['father_name'];
    familyValues = json['family_values'];
    married = json['married'];
    unmarried = json['unmarried'];
    fatherOccupation = json['father_occupation'];
    otherFamilyDetails = json['other_family_details'];
    qualification = json['qualification'];
    profession = json['profession'];
    employeeType = json['employee_type'];
    jobTitle = json['job_title'];
    incomeRange = json['income_range'];
    business = json['business'];
    nameInstitution = json['name_institution'];
    businessText = json['business_text'];
    futurePlan = json['future_plan'];
    smoke = json['smoke'];
    familyInvolvement = json['family_involvement'];
    halalFood = json['halal_food'];
    forBoy = json['for_boy'];
    marriagePeriod = json['marriage_period'];
    forGirl = json['for_girl'];
    lifePartner = json['life_partner'];
    createrProfile = json['creater_profile'];
    enableNotification = json['enable_notification'];
    bio = json['bio'];
    marriageIntension = json['marriage_intension'];
    profilePicture = json['profile_picture'];
    attachments = json['attachments'] != null
        ? Attachments.fromJson(json['attachments'])
        : null;
    if (json['favourite_profiles'] != null) {
      favouriteProfiles = <FavouriteProfiles>[];
      json['favourite_profiles'].forEach((v) {
        favouriteProfiles!.add(FavouriteProfiles.fromJson(v));
      });
    }
    if (json['blocked_profiles'] != null) {
      blockedProfiles = <BlockedProfiles>[];
      json['blocked_profiles'].forEach((v) {
        blockedProfiles!.add(BlockedProfiles.fromJson(v));
      });
    }
    if (json['life_style_and_interest'] != null) {
      lifeStyleAndInterest = <LifeStyleAndInterest>[];
      json['life_style_and_interest'].forEach((v) {
        lifeStyleAndInterest!.add(LifeStyleAndInterest.fromJson(v));
      });
    }
    totalFavouriteProfiles = json['total_favourite_profiles'];
    totalBlockedProfiles = json['total_blocked_profiles'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
    noOfTimesGetBlocked = json['no_of_times_get_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['profile_name'] = this.profileName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['profile_completed'] = this.profileCompleted;
    data['caste'] = this.caste;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['nationality'] = this.nationality;
    data['belongs_to'] = this.belongsTo;
    data['weight'] = this.weight;
    data['material_status'] = this.materialStatus;
    data['ethnicity'] = this.ethnicity;
    data['hight'] = this.hight;
    data['mother_tongue'] = this.motherTongue;
    data['country'] = this.country;
    data['religious_practice'] = this.religiousPractice;
    data['zodiac_sign'] = this.zodiacSign;
    data['have_childern'] = this.haveChildern;
    data['living_arrangement'] = this.livingArrangement;
    data['chatting_period'] = this.chattingPeriod;
    data['employer'] = this.employer;
    data['house_size'] = this.houseSize;
    data['drink_alcohol'] = this.drinkAlcohol;
    data['can_move_abroad_for_marriage'] = this.canMoveAbroadForMarriage;
    data['area_society'] = this.areaSociety;
    data['father_name'] = this.fatherName;
    data['family_values'] = this.familyValues;
    data['married'] = this.married;
    data['unmarried'] = this.unmarried;
    data['father_occupation'] = this.fatherOccupation;
    data['other_family_details'] = this.otherFamilyDetails;
    data['qualification'] = this.qualification;
    data['profession'] = this.profession;
    data['employee_type'] = this.employeeType;
    data['job_title'] = this.jobTitle;
    data['income_range'] = this.incomeRange;
    data['business'] = this.business;
    data['name_institution'] = this.nameInstitution;
    data['business_text'] = this.businessText;
    data['future_plan'] = this.futurePlan;
    data['smoke'] = this.smoke;
    data['family_involvement'] = this.familyInvolvement;
    data['halal_food'] = this.halalFood;
    data['for_boy'] = this.forBoy;
    data['marriage_period'] = this.marriagePeriod;
    data['for_girl'] = this.forGirl;
    data['life_partner'] = this.lifePartner;
    data['creater_profile'] = this.createrProfile;
    data['enable_notification'] = this.enableNotification;
    data['bio'] = this.bio;
    data['marriage_intension'] = this.marriageIntension;
    data['profile_picture'] = this.profilePicture;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.toJson();
    }
    if (this.favouriteProfiles != null) {
      data['favourite_profiles'] =
          this.favouriteProfiles!.map((v) => v.toJson()).toList();
    }
    if (this.blockedProfiles != null) {
      data['blocked_profiles'] =
          this.blockedProfiles!.map((v) => v.toJson()).toList();
    }
    if (this.lifeStyleAndInterest != null) {
      data['life_style_and_interest'] =
          this.lifeStyleAndInterest!.map((v) => v.toJson()).toList();
    }
    data['total_favourite_profiles'] = this.totalFavouriteProfiles;
    data['total_blocked_profiles'] = this.totalBlockedProfiles;
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

class FavouriteProfiles {
  String? profileId;
  String? profileName;
  String? addedOn;

  FavouriteProfiles({this.profileId, this.profileName, this.addedOn});

  FavouriteProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    profileName = json['profile_name'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['profile_name'] = this.profileName;
    data['added_on'] = this.addedOn;
    return data;
  }
}

class BlockedProfiles {
  String? profileId;
  String? profileName;
  String? reason;

  BlockedProfiles({this.profileId, this.profileName, this.reason});

  BlockedProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    profileName = json['profile_name'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['profile_name'] = this.profileName;
    data['reason'] = this.reason;
    return data;
  }
}

class LifeStyleAndInterest {
  String? name;
  String? value;

  LifeStyleAndInterest({this.name, this.value});

  LifeStyleAndInterest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}