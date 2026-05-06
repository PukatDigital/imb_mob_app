import 'package:flutter/foundation.dart';

import '../application/network/result.dart';
import '../data/remote_data_source/i_api.dart';
import '../di/di.dart';
import 'base_mixin.dart';

class BaseViewModel extends ChangeNotifier with BaseMixin {
  @protected
  void setState() => notifyListeners();

  IApi api = inject<IApi>();

  ApiResponse _apiResponse = None();

  ApiResponse get apiResponse => _apiResponse;

  set apiResponse(ApiResponse value) {
    _apiResponse = value;
    setState();
  }

// set role(String? value) {
//   UserModel? userModel = iPrefHelper.retrieveUser();
//   userModel?.data?.role = value;
//   iPrefHelper.saveUser(userModel!);
//   setState();
// }
}
