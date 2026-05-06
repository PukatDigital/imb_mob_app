
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_model/Auth_login_model.dart';
import '../../models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../models/user_object.dart';

abstract class IPrefHelper {
  String? retrieveRefreshToken();

  void saveRefreshToken(value);

  String? retrieveToken();

  void saveToken(value);

  String? retrieveNetworkType();

  void saveNetworkType(value);

  void removeToken();

  void removeUser();

  LoginModel? get loginModel;
  String? get fcmToken;
  void saveLoginModel(LoginModel model);
  void autoLocationUpdate(bool value);

  bool getAutoLocationUpdate();

  SharedPreferences get();

  UserObject? retrieveUser();

  Future<bool> saveUser(UserObject value);


  void setTime(DateTime date);

  bool isTimeMatch();

  void clear();


  // Setup Profile
  SetupProfilePrefModel? retrieveSetupProfile();
  void saveSetupProfile(SetupProfilePrefModel model);
  void clearSetupProfile();
}