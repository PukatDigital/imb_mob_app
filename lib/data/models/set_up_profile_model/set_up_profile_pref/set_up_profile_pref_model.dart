class SetupProfilePrefModel {
  // Page 1
  String? profileName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? motherTongue;
  String? caste;
  String? height;
  String? weight;
  String? materialStatus;
  String? country;
  String? ethnicity;
  String? nationality;
  String? religion;
  String? belongsTo;
  String? religiousPractice;
  String? zodiacSign;

  // Page 2
  String? fatherName;
  String? fatherOccupation;
  String? familyValues;
  String? livingArrangement;
  String? married;
  String? unmarried;
  String? houseSize;
  String? areaSociety;
  String? canMoveAbroadForMarriage;
  String? haveChildren;
  String? otherFamilyDetails;

  // Page 3
  String? qualification;
  String? nameInstitution;
  String? profession;
  String? employer;
  String? employeeType;
  String? jobTitle;
  String? income;
  String? business;
  String? businessText;

  // Page 4
  List<String>? lifeStyleAndInterest;
  String? futurePlan;
  String? familyInvolvement;
  String? marriagePeriod;
  String? smoke;
  String? halalFood;
  String? forGirl;
  String? forBoy;
  String? lifePartner;

  // Page 6
  List<String>? images;
  String? attach1;
  String? attach2;
  String? attach3;
  String? attach4;
  String? attach1Base64;
  String? attach2Base64;
  String? attach3Base64;
  String? attach4Base64;

  // Page 7
  String? bio;
  String? marriageIntension;
  String? createrProfile;
  String? enableNotification;

  SetupProfilePrefModel({
    this.profileName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.motherTongue,
    this.caste,
    this.height,
    this.weight,
    this.materialStatus,
    this.country,
    this.ethnicity,
    this.nationality,
    this.religion,
    this.belongsTo,
    this.religiousPractice,
    this.zodiacSign,
    this.fatherName,
    this.fatherOccupation,
    this.familyValues,
    this.livingArrangement,
    this.married,
    this.unmarried,
    this.houseSize,
    this.areaSociety,
    this.canMoveAbroadForMarriage,
    this.haveChildren,
    this.otherFamilyDetails,
    this.qualification,
    this.nameInstitution,
    this.profession,
    this.employer,
    this.employeeType,
    this.jobTitle,
    this.income,
    this.business,
    this.businessText,
    this.lifeStyleAndInterest,
    this.futurePlan,
    this.familyInvolvement,
    this.marriagePeriod,
    this.smoke,
    this.halalFood,
    this.forGirl,
    this.forBoy,
    this.lifePartner,
    this.images,
    this.attach1,
    this.attach2,
    this.attach3,
    this.attach4,
    this.attach1Base64,
    this.attach2Base64,
    this.attach3Base64,
    this.attach4Base64,
    this.bio,
    this.marriageIntension,
    this.createrProfile,
    this.enableNotification,
  });

  factory SetupProfilePrefModel.fromJson(Map<String, dynamic> json) {
    return SetupProfilePrefModel(
      profileName:       json['profile_name'],
      lastName:          json['last_name'],
      gender:            json['gender'],
      dateOfBirth:       json['date_of_birth'],
      motherTongue:      json['mother_tongue'],
      caste:             json['caste'],
      height:            json['hight'],
      weight:            json['weight'],
      materialStatus:    json['material_status'],
      country:           json['country'],
      ethnicity:         json['ethnicity'],
      nationality:       json['nationality'],
      religion:          json['religion'],
      belongsTo:         json['belongs_to'],
      religiousPractice: json['religious_practice'],
      zodiacSign:        json['zodiac_sign'],

      fatherName:               json['father_name'],
      fatherOccupation:         json['father_occupation'],
      familyValues:             json['family_values'],
      livingArrangement:        json['living_arrangement'],
      married:                  json['married'],
      unmarried:                json['unmarried'],
      houseSize:                json['house_size'],
      areaSociety:              json['area_society'],
      canMoveAbroadForMarriage: json['can_move_abroad_for_marriage'],
      haveChildren:             json['have_childern'],
      otherFamilyDetails:       json['other_family_details'],

      qualification:   json['qualification'],
      nameInstitution: json['name_institution'],
      profession:      json['profession'],
      employer:        json['employer'],
      employeeType:    json['employee_type'],
      jobTitle:        json['job_title'],
      income:          json['income'],
      business:        json['business'],
      businessText:    json['business_text'],

      lifeStyleAndInterest: json['life_style_and_interest'] != null
          ? List<String>.from(json['life_style_and_interest'])
          : [],
      futurePlan:        json['future_plan'],
      familyInvolvement: json['family_involvement'],
      marriagePeriod:    json['marriage_period'],
      smoke:             json['smoke'],
      halalFood:         json['halal_food'],
      forGirl:           json['for_girl'],
      forBoy:            json['for_boy'],
      lifePartner:       json['life_partner'],

      // ✅ Local paths — consistent keys (no 'attached_2' typo in prefs)
      images:  json['images'] != null ? List<String>.from(json['images']) : [],
      attach1: json['attach_1'],
      attach2: json['attach_2'],   // ✅ prefs mein 'attach_2' (API typo sirf payload mein)
      attach3: json['attach_3'],
      attach4: json['attach_4'],

      // ✅ Base64
      attach1Base64: json['attach_1_base64'],
      attach2Base64: json['attach_2_base64'],
      attach3Base64: json['attach_3_base64'],
      attach4Base64: json['attach_4_base64'],

      bio:                json['bio'],
      marriageIntension:  json['marriage_intension'],
      createrProfile:     json['creater_profile'],
      enableNotification: json['enable_notification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_name':      profileName,
      'last_name':         lastName,
      'gender':            gender,
      'date_of_birth':     dateOfBirth,
      'mother_tongue':     motherTongue,
      'caste':             caste,
      'hight':             height,
      'weight':            weight,
      'material_status':   materialStatus,
      'country':           country,
      'ethnicity':         ethnicity,
      'nationality':       nationality,
      'religion':          religion,
      'belongs_to':        belongsTo,
      'religious_practice': religiousPractice,
      'zodiac_sign':       zodiacSign,

      'father_name':                fatherName,
      'father_occupation':          fatherOccupation,
      'family_values':              familyValues,
      'living_arrangement':         livingArrangement,
      'married':                    married,
      'unmarried':                  unmarried,
      'house_size':                 houseSize,
      'area_society':               areaSociety,
      'can_move_abroad_for_marriage': canMoveAbroadForMarriage,
      'have_childern':              haveChildren,
      'other_family_details':       otherFamilyDetails,

      'qualification':    qualification,
      'name_institution': nameInstitution,
      'profession':       profession,
      'employer':         employer,
      'employee_type':    employeeType,
      'job_title':        jobTitle,
      'income':           income,
      'business':         business,
      'business_text':    businessText,

      'life_style_and_interest': lifeStyleAndInterest,
      'future_plan':       futurePlan,
      'family_involvement': familyInvolvement,
      'marriage_period':   marriagePeriod,
      'smoke':             smoke,
      'halal_food':        halalFood,
      'for_girl':          forGirl,
      'for_boy':           forBoy,
      'life_partner':      lifePartner,

      // ✅ images list + local paths — sab save honge prefs mein
      'images':    images ?? [],
      'attach_1':  attach1 ?? '',
      'attach_2':  attach2 ?? '',   // ✅ consistent key
      'attach_3':  attach3 ?? '',
      'attach_4':  attach4 ?? '',

      // ✅ Base64 — API ke liye
      'attach_1_base64': attach1Base64 ?? '',
      'attach_2_base64': attach2Base64 ?? '',
      'attach_3_base64': attach3Base64 ?? '',
      'attach_4_base64': attach4Base64 ?? '',

      'bio':                bio,
      'marriage_intension': marriageIntension,
      'creater_profile':    createrProfile,
      'enable_notification': enableNotification,
    };
  }
}