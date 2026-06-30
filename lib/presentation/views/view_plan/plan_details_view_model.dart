import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/plans_model/bank_details.dart';
import 'package:ideal_marriage_bureau/data/models/plans_model/plans_list_detail_model.dart';
import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';

import '../../../data/models/plans_model/paln_details_model.dart';
import '../../../data/models/plans_model/payment_list_model.dart';
import '../../../data/models/plans_model/payment_methods_list.dart';

class PlansViewModel extends BaseViewModel {
  ActivePlans activePlans = ActivePlans();
  PaymentListModel paymentListModel=PaymentListModel();
  BankDetailsModel bankDetailsModel =BankDetailsModel();
  PaymentMethodsList paymentMethodsList =PaymentMethodsList();
  PlansListDetailsModel? plansListDetailsModel;

  void getAllPlans(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllPlans();
    apiResponse.fold<ActivePlans>(
      onSuccess: (success) {
        activePlans = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getPaymentListData(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getAllPaymentList();
    apiResponse.fold<PaymentListModel>(
      onSuccess: (success) {
        paymentListModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  void getBankDetails(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getBankDetails();
    apiResponse.fold<BankDetailsModel>(
      onSuccess: (success) {
        bankDetailsModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }

  void createPaymentRecord(
      Map<String, dynamic> data, Result result) async
  {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.createPaymentRecord(data);

    apiResponse.fold<String>(
      onSuccess: (message) {
        notifyListeners();
        result.onSuccess(message);
      },
      onError: (error) {
        notifyListeners();
        result.onError(error);
      },
    );
  }
  Future<void> getPlanListDetails(
      Result result, {
        required String planId,
      }) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getPlanListDetails({"plan_id": planId});
    apiResponse.fold<PlansListDetailsModel>(
      onSuccess: (res) {
        plansListDetailsModel = res;
        d("✅ Plan Details: ${res.toJson()}");
        d("🔍 Sending plan_id: $planId");

        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        d("❌ Plan Details error: $err");
        result.onError(err);
      },
    );
  }

  Future<void> getProblemList(
      Result result, {
        required String searchName,
      }) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getPaymentMethodList({"payment_method": searchName});

    apiResponse.fold<PaymentMethodsList>(
      onSuccess: (res) {
        paymentMethodsList = res;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        result.onError(err);
      },
    );
  }
 
}