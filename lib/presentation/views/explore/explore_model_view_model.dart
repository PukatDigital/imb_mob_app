
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/castes_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/education_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/ethnicities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/material_status_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/religions_model.dart';
import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
import '../../../data/models/explore_model/explore_model.dart';
import '../../../data/models/set_up_profile_model/marriage_periods_model.dart';

class ExploreViewModel extends BaseViewModel {

  CastesModel castesModel = CastesModel();
  MaterialStatusModel martialStatuses = MaterialStatusModel();
  ReligionsModel religionsModel = ReligionsModel();
  EducationModel educationModel = EducationModel();
  EthnicitiesModel ethnicitiesModel = EthnicitiesModel();
  MarriagePeriodsModel marriagePeriodsModel = MarriagePeriodsModel();
  ExploreDataModel exploreDataModel =ExploreDataModel();


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

  Future<void> exploreList(
      Result result, {
        required Map<String, dynamic> filterParams,
      }) async {
    apiResponse = Loading();
    notifyListeners();

    // Remove empty keys so API doesn't get blank params
    final cleanedParams = Map<String, dynamic>.fromEntries(
      filterParams.entries.where((e) => e.value != null && e.value.toString().isNotEmpty),
    );

    apiResponse = await api.getExploreProfile(cleanedParams);

    apiResponse.fold<ExploreDataModel>(
      onSuccess: (res) {
        exploreDataModel = res;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        result.onError(err);
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
