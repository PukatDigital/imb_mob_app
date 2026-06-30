
import '../../application/network/result.dart';

abstract class IApi {
  Future<ApiResponse> signInByEmail(Map<String, dynamic> data);
  Future<ApiResponse> userSignUp(Map<String, dynamic> data);
  Future<ApiResponse> emailVerification(Map<String, dynamic> data);
  Future<ApiResponse> forgetEmailVerification(Map<String, dynamic> data);
  Future<ApiResponse> otpVerification(Map<String, dynamic> data);
  Future<ApiResponse> updateOtpVerification(Map<String, dynamic> data);
  Future<ApiResponse> signUp(Map<String, dynamic> data);
  Future<ApiResponse> resetPassword(Map<String, dynamic> data);
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
  Future<ApiResponse> getProblemType();
  Future<ApiResponse> getProblemList(Map<String, dynamic> data);
  Future<ApiResponse> getAllProfileDetails(Map<String, dynamic> data);
  Future<ApiResponse> getProblemDetails(Map<String, dynamic> data);
  Future<ApiResponse> getPlanListDetails(Map<String, dynamic> data);

  Future<ApiResponse> submitSetUpProfile(Map<String, dynamic> data);
  Future<ApiResponse> sendIntrest(Map<String, dynamic> data);
  Future<ApiResponse> createReportProblem(Map<String, dynamic> data);
  Future<ApiResponse> createPaymentRecord(Map<String, dynamic> data);
  Future<ApiResponse> deactivateAccount(Map<String, dynamic> data);
  Future<ApiResponse> updateProfile(Map<String, dynamic> data);
  Future<ApiResponse> addToFavourite(Map<String, dynamic> data);
  Future<ApiResponse> addToBlock(Map<String, dynamic> data);
  Future<ApiResponse> addToReport(Map<String, dynamic> data);
  Future<ApiResponse> addToDeleteAccount(Map<String, dynamic> data);

  Future<ApiResponse> getBlockProfile(Map<String, dynamic> data);
  Future<ApiResponse> getDeactivateProfile(Map<String, dynamic> data);
  Future<ApiResponse> getImpressionList();
  Future<ApiResponse> getFavouriteProfile(Map<String, dynamic> data);
  Future<ApiResponse> getExploreProfile(Map<String, dynamic> data);

  Future<ApiResponse> updateProfilePicture(Map<String, dynamic> data);
  Future<ApiResponse> getTermsAndConditions();
  Future<ApiResponse> getAllPlans();
  Future<ApiResponse> getAllPaymentList();

  Future<ApiResponse> getBankDetails();
  Future<ApiResponse> getPaymentMethodList(Map<String, dynamic> data);
  Future<ApiResponse> getConversationListData();
  Future<ApiResponse> getMessageHistory(int conversationId, Map<String, dynamic> queryParams);
  Future<ApiResponse> sentMessage(Map<String, dynamic> data);


}
