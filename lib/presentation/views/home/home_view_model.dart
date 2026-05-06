import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/application/network/result.dart';
import 'package:ideal_marriage_bureau/base/base_view_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/profile_details_model.dart';

import '../../../application/common/log.dart';

class GetProfileViewModel extends BaseViewModel {

  GetProfileModel getProfileModel = GetProfileModel();
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();

  List<Profiles> get profiles => getProfileModel.data?.profiles ?? [];

  void getAllProfiles(ErrorResult result) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getAllProfiles();
    apiResponse.fold<GetProfileModel>(
      onSuccess: (success) {
        getProfileModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  Future<void> getAllProfileDetails(Result result, {required String profileId}) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getAllProfileDetails({"profile_id": profileId});

    apiResponse.fold<ProfileDetailsModel>(
      onSuccess: (res) {
        profileDetailsModel = res;
        d("✅ Profile Details: ${res.toJson()}");
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        d("❌ Profile Details error: $err");
        result.onError(err);
      },
    );
  }
  void addToFavouriteList(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.addToFavourite(data);

    apiResponse.fold(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void addToBlockUser(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.addToBlock(data);

    apiResponse.fold(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void addToReportUser(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.addToReport(data);

    apiResponse.fold(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  // Future<void> getAllProfileDetails(Result result)
  // async {
  //   apiResponse = Loading();
  //   apiResponse = await api.getAllProfileDetails({}); // no params required
  //   apiResponse.fold<ProfileDetailsModel>(
  //     onSuccess: (res) {
  //
  //       profileDetailsModel = res;
  //       d("✅ Profile Data: ${res.toJson()}");
  //       notifyListeners();
  //       result.onSuccess(res);
  //     },
  //     onError: (err) {
  //       d("❌ Profile Data error: $err");
  //       result.onError(err);
  //     },
  //   );
  // }
}