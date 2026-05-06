
import '../../application/network/result.dart';

abstract class IApi {
  Future<ApiResponse> signInByEmail(Map<String, dynamic> data);
  Future<ApiResponse> userSignUp(Map<String, dynamic> data);
  Future<ApiResponse> emailVerification(Map<String, dynamic> data);
  Future<ApiResponse> otpVerification(Map<String, dynamic> data);
  Future<ApiResponse> signUp(Map<String, dynamic> data);
  Future<ApiResponse> getMotherTongues();
  Future<ApiResponse> getAllCastes();
  Future<ApiResponse> getAllHeights();
  Future<ApiResponse> getAllWeights();
  Future<ApiResponse> getAllMartialStatus();
  Future<ApiResponse> getAllCountry();
  Future<ApiResponse> getAllCities();
  Future<ApiResponse> getAllNationalities();
  Future<ApiResponse> getAllReligions();
  Future<ApiResponse> getAllBelongsTo();
  Future<ApiResponse> getAllReligiousPractices();
  Future<ApiResponse> getAllZodiacSigns();
  Future<ApiResponse> getAllOccupations();
  Future<ApiResponse> getAllFamilyValues();
  Future<ApiResponse> getAllEducation();
  Future<ApiResponse> getAllProfessions();
  Future<ApiResponse> getAllEmployeeTypes();
  Future<ApiResponse> getAllIncomeRanges();
  Future<ApiResponse> getAllFuturePlans();
  Future<ApiResponse> getAllMarriagePeriods();
  Future<ApiResponse> getAllProfileCreators();
  Future<ApiResponse> getAllLivingArrangements();
  Future<ApiResponse> getAllEthnicities();
  Future<ApiResponse> getAllLifeStyleAndInterest();
  Future<ApiResponse> getAllProfiles();
  Future<ApiResponse> getAllProfileDetails(Map<String, dynamic> data);

  Future<ApiResponse> submitSetUpProfile(Map<String, dynamic> data);
  Future<ApiResponse> addToFavourite(Map<String, dynamic> data);
  Future<ApiResponse> addToBlock(Map<String, dynamic> data);
  Future<ApiResponse> addToReport(Map<String, dynamic> data);
  Future<ApiResponse> getBlockProfile(Map<String, dynamic> data);
  Future<ApiResponse> getFavouriteProfile(Map<String, dynamic> data);


}
