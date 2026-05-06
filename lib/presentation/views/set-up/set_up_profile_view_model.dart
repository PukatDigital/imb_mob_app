
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/belongs_to_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/castes_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/countries_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/education_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/employee_types_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/ethnicities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/family_values_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/future_plans_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/heights_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/income_range_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/living_arrangements_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/marriage_periods_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/material_status_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/mother_tongues_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/nationalities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/occupations_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/professions_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/profile_creators_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/religions_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/religious_practices_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/weights_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/zodiac_signs_model.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
import '../../../data/models/set_up_profile_model/life_style_and_interest_model.dart';

class SetUpProfileViewModel extends BaseViewModel {

  MotherTonguesModel motherTonguesModel = MotherTonguesModel();
  CastesModel castesModel = CastesModel();
  HeightsModel heightsModel = HeightsModel();
  WeightsModel weightsModel = WeightsModel();
  MaterialStatusModel martialStatuses = MaterialStatusModel();
  CountriesModel countriesModel = CountriesModel();
  NationalitiesModel nationalitiesModel = NationalitiesModel();
  ReligionsModel religionsModel = ReligionsModel();
  BelongsToModel belongsToModel = BelongsToModel();
  ReligiousPracticesModel religiousPracticesModel = ReligiousPracticesModel();
  ZodiacSignsModel zodiacSignsModel = ZodiacSignsModel();
  OccupationsModel occupationsModel = OccupationsModel();
  FamilyValuesModel familyValuesModel = FamilyValuesModel();
  EducationModel educationModel = EducationModel();
  ProfessionsModel professionsModel = ProfessionsModel();
  EmployeeTypesModel employeeTypesModel = EmployeeTypesModel();
  IncomeRangesModel incomeRangesModel = IncomeRangesModel();
  FuturePlansModel futurePlansModel = FuturePlansModel();
  MarriagePeriodsModel marriagePeriodsModel = MarriagePeriodsModel();
  ProfileCreatorsModel profileCreatorsModel = ProfileCreatorsModel();
  LivingArrangementsModel livingArrangementsModel = LivingArrangementsModel();
  EthnicitiesModel ethnicitiesModel = EthnicitiesModel();
  LifeStyleModel lifeStyleModel = LifeStyleModel();


  void getMotherTonguesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getMotherTongues();
    apiResponse.fold<MotherTonguesModel>(  // ← generic type matches
      onSuccess: (success) {
        motherTonguesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllCasteData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllCastes();
    apiResponse.fold<CastesModel>(  // ← generic type matches
      onSuccess: (success) {
        castesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllHeightsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllHeights();
    apiResponse.fold<HeightsModel>(  // ← generic type matches
      onSuccess: (success) {
        heightsModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllWeightsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllWeights();
    apiResponse.fold<WeightsModel>(  // ← generic type matches
      onSuccess: (success) {
        weightsModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllMartialStatusData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllMartialStatus();
    apiResponse.fold<MaterialStatusModel>(  // ← generic type matches
      onSuccess: (success) {
        martialStatuses = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllCountryData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllCountry();
    apiResponse.fold<CountriesModel>(  // ← generic type matches
      onSuccess: (success) {
        countriesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllNationalitiesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllNationalities();
    apiResponse.fold<NationalitiesModel>(  // ← generic type matches
      onSuccess: (success) {
        nationalitiesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllReligionsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllReligions();
    apiResponse.fold<ReligionsModel>(  // ← generic type matches
      onSuccess: (success) {
        religionsModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllBelongsToData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllBelongsTo();
    apiResponse.fold<BelongsToModel>(  // ← generic type matches
      onSuccess: (success) {
        belongsToModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllReligiousPracticesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllReligiousPractices();
    apiResponse.fold<ReligiousPracticesModel>(  // ← generic type matches
      onSuccess: (success) {
        religiousPracticesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllZodiacSignsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllZodiacSigns();
    apiResponse.fold<ZodiacSignsModel>(  // ← generic type matches
      onSuccess: (success) {
        zodiacSignsModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllOccupationsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllOccupations();
    apiResponse.fold<OccupationsModel>(  // ← generic type matches
      onSuccess: (success) {
        occupationsModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllFamilyValuesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllFamilyValues();
    apiResponse.fold<FamilyValuesModel>(  // ← generic type matches
      onSuccess: (success) {
        familyValuesModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllEducationData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllEducation();
    apiResponse.fold<EducationModel>(  // ← generic type matches
      onSuccess: (success) {
        educationModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllProfessionsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllProfessions();
    apiResponse.fold<ProfessionsModel>(  // ← generic type matches
      onSuccess: (success) {
        professionsModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllEmployeeTypesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllEmployeeTypes();
    apiResponse.fold<EmployeeTypesModel>(  // ← generic type matches
      onSuccess: (success) {
        employeeTypesModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllIncomeRangesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllIncomeRanges();
    apiResponse.fold<IncomeRangesModel>(  // ← generic type matches
      onSuccess: (success) {
        incomeRangesModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllFuturePlansData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllFuturePlans();
    apiResponse.fold<FuturePlansModel>(  // ← generic type matches
      onSuccess: (success) {
        futurePlansModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllMarriagePeriodsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllMarriagePeriods();
    apiResponse.fold<MarriagePeriodsModel>(  // ← generic type matches
      onSuccess: (success) {
        marriagePeriodsModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllProfileCreatorsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllProfileCreators();
    apiResponse.fold<ProfileCreatorsModel>(  // ← generic type matches
      onSuccess: (success) {
        profileCreatorsModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllLivingArrangementsData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllLivingArrangements();
    apiResponse.fold<LivingArrangementsModel>(  // ← generic type matches
      onSuccess: (success) {
        livingArrangementsModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllEthnicitiesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllEthnicities();
    apiResponse.fold<EthnicitiesModel>(  // ← generic type matches
      onSuccess: (success) {
        ethnicitiesModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllLifeStyleAndInterestData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllLifeStyleAndInterest();
    apiResponse.fold<LifeStyleModel>(  // ← generic type matches
      onSuccess: (success) {
        lifeStyleModel= success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }


  void submitSetUpProfileData(
      Map<String, dynamic> data, Result result) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.submitSetUpProfile(data);

    apiResponse.fold<String>(
      onSuccess: (message) {
        notifyListeners();
        result.onSuccess(message);
      },
      onError: (error) {
        notifyListeners();
        result.onError(error);
      },
    );
  }

  //
  // void submitSetUpProfileData(Map<String, dynamic> data, Result result) async {
  //   apiResponse = Loading();
  //   apiResponse = await api.submitSetUpProfile(data);
  //   apiResponse.fold<String>(
  //     onSuccess: result.onSuccess,
  //     onError: result.onError,
  //   );
  // }
}
