import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/application/network/result.dart';
import 'package:ideal_marriage_bureau/base/base_view_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/profile_details_model.dart';

import '../../../application/common/log.dart';
import '../../../data/models/get_profile_model/deactivate_profile_model.dart';

class GetPersonalProfileViewModel extends BaseViewModel {
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();
  DeactivateProfileModel deactivateProfileModel = DeactivateProfileModel();
  ProfileData? get profileData => profileDetailsModel.data; // expose the private field
  Future<void> getAllPersonalProfileDetails(Result result, {required String profileId}) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getAllProfileDetails({"user_id": profileId});

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
  Future<void> getDeactivateProfile(Map<String, dynamic> data,Result result) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getDeactivateProfile(data);

    apiResponse.fold<DeactivateProfileModel>(
      onSuccess: (res) {
        deactivateProfileModel = res;
        d("✅ Activation Details: ${res.toJson()}");
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        d("❌ Profile Details error: $err");
        result.onError(err);
      },
    );
  }
  void deactivateAccount(
      Map<String, dynamic> data, Result result) async
  {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.deactivateAccount(data);

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

  void updateProfileImages(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.updateProfilePicture(data);

    apiResponse.fold(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void addToDeleteAccount(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.addToDeleteAccount(data);

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