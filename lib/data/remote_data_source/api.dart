import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/profile_details_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/belongs_to_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/castes_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/cities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/countries_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/education_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/employee_types_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/ethnicities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/family_values_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/future_plans_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/heights_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/income_range_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/life_style_and_interest_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/living_arrangements_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/marriage_periods_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/material_status_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/mother_tongues_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/nationalities_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/occupations_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/professions_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/profile_creators_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/religions_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/religious_practices_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/weights_model.dart';
import 'package:ideal_marriage_bureau/data/models/set_up_profile_model/zodiac_signs_model.dart';


import '../../application/common/log.dart';
import '../../application/network/client/i_api_service.dart';
import '../../application/network/error-handler/error_handler.dart';
import '../../application/network/result.dart';

import '../models/block_model/block_model.dart';
import '../models/explore_model/explore_model.dart';
import '../models/favourite_model/favourite_model.dart';
import '../models/login_model/Auth_login_model.dart';

import 'i_api.dart';

class Apis implements IApi {
  final IApiService apiService;

  Apis(this.apiService) : dio = apiService.get();

  late final Dio dio;

  @override
  Future<ApiResponse> signInByEmail(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: false);
    try {
      final response = await dio.post(
        "method/onebms.api.auth.login_api",
        data: data,
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
            Headers.acceptHeader: "application/json",
          },
        ),
      );

      d("🔹 Login API Response: ${response.data}");

      if (response.data is Map) {
        final loginModel = LoginModel.fromJson(response.data);

        // ✅ Check success flag inside data
        if (loginModel.data?.success == true) {
          return Success(loginModel);
        } else {
          // ❌ Login failed — use inner message e.g. "Incorrect password..."
          final errorMessage =
              loginModel.data?.message ?? loginModel.message ?? "Login failed";
          return Error(errorMessage);
        }
      }

      return Error("Unexpected API response. Please try again later.");

    } on DioException catch (e) {
      final errorMessage = getErrorMessage(e);
      d("❌ DioException: $errorMessage");
      return Error(errorMessage);

    } catch (e) {
      d("❌ Exception: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> emailVerification(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: false);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.auth.send_signup_otp",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> otpVerification(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: false);
    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.auth.verify_signup_otp",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> signUp(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: false);
    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.auth.create_user_profile",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }

  @override
  Future<ApiResponse> getMotherTongues() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_mother_tongues",
      );
      d("RAW Response: ${responseData.data}");
      return Success(MotherTonguesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllCastes() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_castes",
      );
      d("RAW Response: ${responseData.data}");
      return Success(CastesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllHeights() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_heights",
      );
      d("RAW Response: ${responseData.data}");
      return Success(HeightsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllWeights() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_weights",
      );
      d("RAW Response: ${responseData.data}");
      return Success(WeightsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllMartialStatus() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_martial_status",
      );
      d("RAW Response: ${responseData.data}");
      return Success(MaterialStatusModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllCountry() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_countries",
      );
      d("RAW Response: ${responseData.data}");
      return Success(CountriesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllCities() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_ethnicities",
      );
      d("RAW Response: ${responseData.data}");
      return Success(CitiesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllNationalities() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_nationalities",
      );
      d("RAW Response: ${responseData.data}");
      return Success(NationalitiesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllReligions() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_religions",
      );
      d("RAW Response: ${responseData.data}");
      return Success(ReligionsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllBelongsTo() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_belongs_to",
      );
      d("RAW Response: ${responseData.data}");
      return Success(BelongsToModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllReligiousPractices() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_religious_practices",
      );
      d("RAW Response: ${responseData.data}");
      return Success(ReligiousPracticesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllZodiacSigns() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_zodiac_signs",
      );
      d("RAW Response: ${responseData.data}");
      return Success(ZodiacSignsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllOccupations() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_occupations",
      );
      d("RAW Response: ${responseData.data}");
      return Success(OccupationsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllFamilyValues() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_family_values",
      );
      d("RAW Response: ${responseData.data}");
      return Success(FamilyValuesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllEducation() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_education",
      );
      d("RAW Response: ${responseData.data}");
      return Success(EducationModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllProfessions() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_professions",
      );
      d("RAW Response: ${responseData.data}");
      return Success(ProfessionsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllEmployeeTypes() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_employee_types",
      );
      d("RAW Response: ${responseData.data}");
      return Success(EmployeeTypesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllIncomeRanges() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_income_ranges",
      );
      d("RAW Response: ${responseData.data}");
      return Success(IncomeRangesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllFuturePlans() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_future_plans",
      );
      d("RAW Response: ${responseData.data}");
      return Success(FuturePlansModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllMarriagePeriods() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_marriage_periods",
      );
      d("RAW Response: ${responseData.data}");
      return Success(MarriagePeriodsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllProfileCreators() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_profile_creators",
      );
      d("RAW Response: ${responseData.data}");
      return Success(ProfileCreatorsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllLivingArrangements() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_living_arrangements",
      );
      d("RAW Response: ${responseData.data}");
      return Success(LivingArrangementsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllEthnicities() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_ethnicities",
      );
      d("RAW Response: ${responseData.data}");
      return Success(EthnicitiesModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllLifeStyleAndInterest() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.base_api.get_all_life_style_and_interest",
      );
      d("RAW Response: ${responseData.data}");
      return Success(LifeStyleModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllProfiles() async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.profile_api.get_all_profiles",
      );
      d("RAW Response: ${responseData.data}");
      return Success(GetProfileModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("DioException Type: ${e.type}");
      d("Status Code: ${e.response?.statusCode}");
      d("Response Data: ${e.response?.data}");
      d("Request URL: ${e.requestOptions.uri}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("Unknown Error: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getAllProfileDetails(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.profile_api.get_profile_details",
        queryParameters: data, // sends profile_id as query param
      );
      d("✅ API Response: ${responseData.data}");
      return Success(ProfileDetailsModel.fromJson(responseData.data));
    } on DioException catch (e) {
      d("❌ DioException: $e");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("❌ Exception: $e");
      return Error(e.toString());
    }
  }

  @override
  Future<ApiResponse> submitSetUpProfile(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      d("🚀 SUBMIT DATA: ${jsonEncode(data)}"); // log actual JSON
      final responseData = await dio.post(
        "method/onebms.api.profile_api.create_profile",
        data: jsonEncode(data), // always send JSON
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      d("✅ STATUS: ${responseData.statusCode}");
      d("📩 RESPONSE: ${responseData.data}");
      return Success(responseData.data['message']);
    } on DioException catch (e) {
      d("❌ DIO ERROR: ${e.response?.data}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("❌ UNKNOWN ERROR: $e");
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> updateProfile(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      d("🚀 UPDATE DATA: ${jsonEncode(data)}"); // log actual JSON
      final responseData = await dio.post(
        "method/onebms.api.profile_api.update_profile",
        data: jsonEncode(data), // always send JSON
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      d("✅ STATUS: ${responseData.statusCode}");
      d("📩 RESPONSE: ${responseData.data}");
      return Success(responseData.data['message']);
    } on DioException catch (e) {
      d("❌ DIO ERROR: ${e.response?.data}");
      return Error(getErrorMessage(e));
    } catch (e) {
      d("❌ UNKNOWN ERROR: $e");
      return Error(e.toString());
    }
  }

  @override
  Future<ApiResponse> userSignUp(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: false);
    try {
      final responseData = await dio.post(
        "/auth/verify",
        data: data,
      );
      return Success(responseData.data['data']['token']);
    } on DioException catch (e) {
      return Error(getErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ApiResponse> addToFavourite(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.profile_api.manage_favourite_profile",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> addToBlock(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.profile_api.manage_blocked_profile",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> addToReport(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.profile_api.report_profile",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> addToDeleteAccount(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.profile_api.delete_profile",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }

  @override
  Future<ApiResponse> getBlockProfile(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.profile_api.get_blocked_profile_list",
        queryParameters: data,
      );

      return Success(BlockedProfileModel.fromJson(responseData.data));
    } on DioException catch (e) {
      return Error(getErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getFavouriteProfile(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.profile_api.get_favourite_profile_list",
        queryParameters: data,
      );

      return Success(FavouriteProfileModel.fromJson(responseData.data));
    } on DioException catch (e) {
      return Error(getErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> getExploreProfile(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);
    try {
      final responseData = await dio.get(
        "method/onebms.api.profile_api.get_matched_profile",
        queryParameters: data,
      );
      return Success(ExploreDataModel.fromJson(responseData.data));
    } on DioException catch (e) {
      return Error(getErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
  @override
  Future<ApiResponse> updateProfilePicture(Map<String, dynamic> data) async {
    apiService.setIsTokenRequired(value: true);

    d(data);
    try {
      final responseData = await dio.post(
        "method/onebms.api.profile_api.update_profile_picture",
        data: data,
      );
      d(responseData.data);
      d(responseData.data["message"]);
      return Success(responseData.data["message"]);
    } on DioException catch (e) {
      d(e);
      return Error(getErrorMessage(e));
    } catch (e) {
      d(e);
      return Error(e.toString());
    }
  }

  //
  // @override
  // Future<ApiResponse> getMotherTongues() async {
  //   apiService.setIsTokenRequired(value: true);
  //   try {
  //     final responseData = await dio.get("get_all_mother_tongues");
  //     d(responseData.toString());
  //     return Success(MotherTonguesModel.fromJson(responseData.data));
  //   } on DioException catch (e) {
  //     return Error(getErrorMessage(e));
  //   } catch (e) {
  //     return Error(e.toString());
  //   }
  // }
}
