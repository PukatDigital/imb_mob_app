import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/plans_model/plans_list_detail_model.dart';
import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';

import '../../../data/models/plans_model/paln_details_model.dart';
import '../../../data/models/plans_model/payment_list_model.dart';

class PlansViewModel extends BaseViewModel {
  ActivePlans activePlans = ActivePlans();
  PaymentListModel paymentListModel=PaymentListModel();
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
 
}