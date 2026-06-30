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
  int? chatUserId;
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
    this.chatUserId,
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
    chatUserId = json['chat_user_id'];
    totalFavouriteProfiles = json['total_favourite_profiles'];
    totalBlockedProfiles = json['total_blocked_profiles'];
    noOfTimesAddedAsFavourite = json['no_of_times_added_as_favourite'];
    noOfTimesGetBlocked = json['no_of_times_get_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['profile_name'] = profileName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['date_of_birth'] = dateOfBirth;
    data['profile_completed'] = profileCompleted;
    data['caste'] = caste;
    data['gender'] = gender;
    data['religion'] = religion;
    data['nationality'] = nationality;
    data['belongs_to'] = belongsTo;
    data['weight'] = weight;
    data['material_status'] = materialStatus;
    data['ethnicity'] = ethnicity;
    data['hight'] = hight;
    data['mother_tongue'] = motherTongue;
    data['country'] = country;
    data['religious_practice'] = religiousPractice;
    data['zodiac_sign'] = zodiacSign;
    data['have_childern'] = haveChildern;
    data['living_arrangement'] = livingArrangement;
    data['chatting_period'] = chattingPeriod;
    data['employer'] = employer;
    data['house_size'] = houseSize;
    data['drink_alcohol'] = drinkAlcohol;
    data['can_move_abroad_for_marriage'] = canMoveAbroadForMarriage;
    data['area_society'] = areaSociety;
    data['father_name'] = fatherName;
    data['family_values'] = familyValues;
    data['married'] = married;
    data['unmarried'] = unmarried;
    data['father_occupation'] = fatherOccupation;
    data['other_family_details'] = otherFamilyDetails;
    data['qualification'] = qualification;
    data['profession'] = profession;
    data['employee_type'] = employeeType;
    data['job_title'] = jobTitle;
    data['income_range'] = incomeRange;
    data['business'] = business;
    data['name_institution'] = nameInstitution;
    data['business_text'] = businessText;
    data['future_plan'] = futurePlan;
    data['smoke'] = smoke;
    data['family_involvement'] = familyInvolvement;
    data['halal_food'] = halalFood;
    data['for_boy'] = forBoy;
    data['marriage_period'] = marriagePeriod;
    data['for_girl'] = forGirl;
    data['life_partner'] = lifePartner;
    data['creater_profile'] = createrProfile;
    data['enable_notification'] = enableNotification;
    data['bio'] = bio;
    data['marriage_intension'] = marriageIntension;
    data['profile_picture'] = profilePicture;
    if (attachments != null) {
      data['attachments'] = attachments!.toJson();
    }
    if (favouriteProfiles != null) {
      data['favourite_profiles'] =
          favouriteProfiles!.map((v) => v.toJson()).toList();
    }
    if (blockedProfiles != null) {
      data['blocked_profiles'] =
          blockedProfiles!.map((v) => v.toJson()).toList();
    }
    if (lifeStyleAndInterest != null) {
      data['life_style_and_interest'] =
          lifeStyleAndInterest!.map((v) => v.toJson()).toList();
    }
    data['chat_user_id'] = chatUserId;
    data['total_favourite_profiles'] = totalFavouriteProfiles;
    data['total_blocked_profiles'] = totalBlockedProfiles;
    data['no_of_times_added_as_favourite'] = noOfTimesAddedAsFavourite;
    data['no_of_times_get_blocked'] = noOfTimesGetBlocked;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attach_1'] = attach1;
    data['attach_2'] = attach2;
    data['attach_3'] = attach3;
    data['attach_4'] = attach4;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['profile_name'] = profileName;
    data['added_on'] = addedOn;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_id'] = profileId;
    data['profile_name'] = profileName;
    data['reason'] = reason;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}