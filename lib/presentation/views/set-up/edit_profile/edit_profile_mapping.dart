
import '../../../../data/models/get_profile_model/profile_details_model.dart';
import '../../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';

class ProfileEditMapper {
  static SetupProfilePrefModel fromProfileData(ProfileData data) {
    return SetupProfilePrefModel(
      // ── Step 1: Tell about yourself ─────────────────────────────────
      profileName:          data.profileName,
      lastName:             data.lastName,
      gender:               data.gender,
      dateOfBirth:          data.dateOfBirth,
      profileId:        data.profileId,
      profileCompleted: data.profileCompleted,
      motherTongue:         data.motherTongue,

      caste:                data.caste,
      height:               data.hight,           // note API typo
      weight:               data.weight,
      materialStatus:       data.materialStatus,
      country:              data.country,
      ethnicity:            data.ethnicity,
      nationality:          data.nationality,
      religion:             data.religion,
      belongsTo:            data.belongsTo,
      religiousPractice:    data.religiousPractice,
      zodiacSign:           data.zodiacSign,

      // ── Step 2: Family ───────────────────────────────────────────────
      fatherName:           data.fatherName,
      fatherOccupation:     data.fatherOccupation,
      familyValues:         data.familyValues,
      livingArrangement:    data.livingArrangement,
      married:              data.married,
      unmarried:            data.unmarried,
      houseSize:            data.houseSize,
      areaSociety:          data.areaSociety,
      canMoveAbroadForMarriage: data.canMoveAbroadForMarriage,
      haveChildren:         data.haveChildern,    // note API typo
      otherFamilyDetails:   data.otherFamilyDetails,

      // ── Step 3: Education & Profession ──────────────────────────────
      qualification:        data.qualification,
      nameInstitution:      data.nameInstitution,
      profession:           data.profession,
      employer:             data.employer,
      employeeType:         data.employeeType,
      jobTitle:             data.jobTitle,
      income:               data.incomeRange,
      business:             data.business,
      businessText:         data.businessText,

      // ── Step 4: Lifestyle & Interest ────────────────────────────────
      // Map List<LifeStyleItem> → List<String> (store the name strings)
      lifeStyleAndInterest: data.lifeStyleAndInterest
          ?.map((e) => e.name ?? '')
          .where((e) => e.isNotEmpty)
          .toList(),
      futurePlan:           data.futurePlan,
      familyInvolvement:    data.familyInvolvement,
      marriagePeriod:       data.marriagePeriod,
      smoke:                data.smoke,
      halalFood:            data.halalFood,

      // ── Step 5: Partner Preferences ─────────────────────────────────
      forGirl:              data.forGirl,
      forBoy:               data.forBoy,
      lifePartner:          data.lifePartner,

      // ── Step 6: Pictures ────────────────────────────────────────────
      // These are already URLs (not local paths); handle in AddYourPictures
      attach1:              data.attachments?.attach1,
      attach2:              data.attachments?.attach2,
      attach3:              data.attachments?.attach3,
      attach4:              data.attachments?.attach4,

      // ── Step 7: Bio & Other ─────────────────────────────────────────
      bio:                  data.bio,
      marriageIntension:    data.marriageIntension,
      createrProfile:       data.createrProfile,
      enableNotification:   data.enableNotification,
    );
  }
}