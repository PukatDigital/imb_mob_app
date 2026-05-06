import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_model/Auth_login_model.dart';
import '../../models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../models/user_object.dart';
import 'i_pref_helper.dart';

class PrefHelper implements IPrefHelper {
  late final SharedPreferences _pref;

  PrefHelper(SharedPreferences preferences) : _pref = preferences;

  @override
  String? retrieveToken() {
    if (_pref.containsKey("userToken")) {
      return _pref.getString("userToken");
    } else {
      return null;
    }
  }

  @override
  void saveToken(value) {
    _pref.setString("userToken", value);
  }

  @override
  String? retrieveNetworkType() {
    if (_pref.containsKey("idType")) {
      return _pref.getString("idType");
    } else {
      return null;
    }
  }

  @override
  void saveNetworkType(value) {
    _pref.setString("idType", value);
  }
  @override
  void clear() {
    _pref.clear();
  }

  @override
  SharedPreferences get() {
    return _pref;
  }

  @override
  void removeToken() {
    _pref.remove('userToken');
  }

  @override
  void removeUser() {
    _pref.remove('user_data');
  }
  @override
  LoginModel? get loginModel {
    final data = _pref.getString('user_data');
    if (data != null) return LoginModel.fromJson(jsonDecode(data));
    return null;
  }
  //
  @override
  String? get fcmToken => loginModel?.data?.sessionId;
  // Save updated login model
  @override
  void saveLoginModel(LoginModel model) {
    _pref.setString('user_data', jsonEncode(model.toJson()));

    // ✅ Save api_key:api_secret as the token for Frappe
    final apiKey = model.data?.user?.apiKey;
    final apiSecret = model.data?.user?.apiSecret;

    if (apiKey != null && apiSecret != null) {
      saveToken("$apiKey:$apiSecret"); // stored as "api_key:api_secret"
    } else if (model.data?.sessionId != null) {
      saveToken(model.data?.sessionId); // fallback
    }
  }
  // @override
  // void saveLoginModel(LoginModel model) {
  //   _pref.setString('user_data', jsonEncode(model.toJson()));
  //   // if (model.data?.fcmToken != null) {
  //   //   saveRefreshToken(model.userInfo!.fcmToken!);
  //   //   // Also save FCM token separately for easy access
  //   //   storedFcmToken = model.userInfo!.fcmToken!;
  //   // }
  //   if (model.data?.sessionId != null) {
  //     saveToken(model.data?.sessionId );
  //   }
  // }
  @override
  void autoLocationUpdate(bool value) {
    _pref.setBool('autoLocationUpdate', value);
  }

  @override
  bool getAutoLocationUpdate() {
    if (_pref.containsKey('autoLocationUpdate')) {
      return _pref.getBool('autoLocationUpdate') ?? true;
    } else {
      return true;
    }
  }

  @override
  UserObject? retrieveUser() {
    if (_pref.containsKey("user_data")) {
      Map<String, dynamic> j = json.decode(_pref.getString("user_data")!);
      return UserObject.fromJson(j);
    } else {
      return null;
    }
  }
  @override
  Future<bool> saveUser(UserObject value) async {
    return await _pref.setString("user_data", json.encode(value.toJson()));
  }
  @override
  bool isTimeMatch() {
    try {
      if (_pref.containsKey("time_matched")) {
        final savedDate = DateTime.parse(_pref.getString("time_matched")!);
        Duration difference = DateTime.now().difference(savedDate);
        int diffMinutes = difference.inMinutes;
        return diffMinutes >= 5;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  @override
  void setTime(DateTime date) {
    String d = date.toIso8601String();
    _pref.setString("time_matched", d);
  }

  @override
  String? retrieveRefreshToken() {
    if (_pref.containsKey("userRefreshToken")) {
      return _pref.getString("userRefreshToken");
    } else {
      return null;
    }
  }

  @override
  void saveRefreshToken(value) {
    _pref.setString("userRefreshToken", value);
  }


  static const String _setupProfileKey = 'setup_profile_data';

  @override
  SetupProfilePrefModel? retrieveSetupProfile() {
    final data = _pref.getString(_setupProfileKey);
    if (data != null) {
      return SetupProfilePrefModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  @override
  void saveSetupProfile(SetupProfilePrefModel model) {
    _pref.setString(_setupProfileKey, jsonEncode(model.toJson()));
  }

  @override
  void clearSetupProfile() {
    _pref.remove(_setupProfileKey);
  }
}
