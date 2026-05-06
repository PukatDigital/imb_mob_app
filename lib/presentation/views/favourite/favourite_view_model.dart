import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/favourite_model/favourite_model.dart';

import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';

class FavouriteViewListModel extends BaseViewModel {
  FavouriteProfileModel favouriteProfileModel = FavouriteProfileModel();

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
}