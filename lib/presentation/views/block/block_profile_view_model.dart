
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/mother_tongues_model.dart';
import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
import '../../../data/models/block_model/block_model.dart';
import '../../../data/models/get_profile_model/profile_details_model.dart';
import '../../../data/models/set_up_profile_model/life_style_and_interest_model.dart';

class BlockViewModel extends BaseViewModel {
  BlockedProfileModel blockedProfileModel = BlockedProfileModel();
  ProfileDetailsModel profileDetailsModel=ProfileDetailsModel();
  Future<void> getBlockProfileUser(Result result,
      {required String profileId}) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse =
    await api.getBlockProfile({"user_id": profileId}); // ✅ FIXED API

    apiResponse.fold<BlockedProfileModel>(
      onSuccess: (res) {
        blockedProfileModel = res;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        result.onError(err);
      },
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
}
