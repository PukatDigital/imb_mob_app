import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/application/network/result.dart';
import 'package:ideal_marriage_bureau/base/base_view_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/profile_details_model.dart';

import '../../../application/common/log.dart';

class GetPersonalProfileViewModel extends BaseViewModel {
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();

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