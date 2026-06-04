
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/cities_model.dart';
import '../../../../application/common/log.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../base/base_view_model.dart';
import '../../../data/models/login_model/Auth_login_model.dart';
import '../../../data/models/set_up_profile_model/countries_model.dart';
import '../../../data/models/set_up_profile_model/education_model.dart';
class AuthViewModel extends BaseViewModel {
  EducationModel educationModel=EducationModel();
  CountriesModel countriesModel=CountriesModel();
  CitiesModel citiesModel=CitiesModel();
  void signInByEmail(Map<String, dynamic> data, Result result) async {
    apiResponse = Loading();
    apiResponse = await api.signInByEmail(data);
    d(data);
    apiResponse.fold<LoginModel>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }

  void emailVerificationCode(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.emailVerification(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void forgetEmailVerificationCode(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.forgetEmailVerification(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }

  void otpVerificationCode(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.otpVerification(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void updateOtpVerificationCode(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.updateOtpVerification(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void signUpUser(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.signUp(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }
  void updatePassword(Map<String, dynamic> data, Result result) async {
    d(data);
    apiResponse = Loading();
    apiResponse = await api.resetPassword(data);
    apiResponse.fold<String>(
      onSuccess: result.onSuccess,
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
  void getAllCountryData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllCountry();
    apiResponse.fold<CountriesModel>(  // ← generic type matches
      onSuccess: (success) {
        countriesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getAllCitiesData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllCities();
    apiResponse.fold<CitiesModel>(  // ← generic type matches
      onSuccess: (success) {
        citiesModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  // void logout(Result result) async {
  //   apiResponse = Loading();
  //   apiResponse = await api.logout();
  //   apiResponse.fold<String>(
  //     onSuccess: result.onSuccess,
  //     onError: result.onError,
  //   );
  // }
  //
  // void forgetPassword(Map<String, dynamic> data, Result result) async {
  //   d(data);
  //   apiResponse = Loading();
  //   apiResponse = await api.forgetPassword(data);
  //   apiResponse.fold<String>(
  //     onSuccess: result.onSuccess,
  //     onError: result.onError,
  //   );
  // }
  // void verifyOTPCode(Map<String, dynamic> data, Result result) async {
  //   d(data);
  //   apiResponse = Loading();
  //   apiResponse = await api.verifyOTP(data);
  //   apiResponse.fold<String>(
  //     onSuccess: result.onSuccess,
  //     onError: result.onError,
  //   );
  // }
  // void resetPassword(Map<String, dynamic> data, Result result) async {
  //   d(data);
  //   apiResponse = Loading();
  //   apiResponse = await api.resetPassword(data);
  //   apiResponse.fold<String>(
  //     onSuccess: result.onSuccess,
  //     onError: result.onError,
  //   );
  // }
// void otp(Map<String, dynamic> data, Result result) async {
//   d(data);
//   apiResponse = Loading();
//   apiResponse = await api.OTP(data);
//   apiResponse.fold<String>(
//     onSuccess: result.onSuccess,
//     onError: result.onError,
//   );
// }
// void changePassword(Map<String, dynamic> data, Result result) async {
//   d(data);
//   apiResponse = Loading();
//   apiResponse = await api.changePassword(data);
//   apiResponse.fold<String>(
//     onSuccess: result.onSuccess,
//     onError: result.onError,
//   );
// }
}
