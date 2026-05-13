import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/favourite_model/favourite_model.dart';

import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
import '../../../data/models/get_profile_model/profile_details_model.dart';

class FavouriteViewListModel extends BaseViewModel {
  FavouriteProfileModel favouriteProfileModel = FavouriteProfileModel();
  ProfileDetailsModel profileDetailsModel =ProfileDetailsModel();
  Future<void> getFavouriteProfile(
      Result result, {
        required String profileId,
      }) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getFavouriteProfile({"profile_name": profileId});

    apiResponse.fold<FavouriteProfileModel>(
      onSuccess: (res) {
        favouriteProfileModel = res;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
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
}