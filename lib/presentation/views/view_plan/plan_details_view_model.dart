import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';

import '../../../data/models/plans_model/paln_details_model.dart';
import '../../../data/models/plans_model/payment_list_model.dart';

class PlansViewModel extends BaseViewModel {
  ActivePlans activePlans = ActivePlans();
  PaymentListModel paymentListModel=PaymentListModel();

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


 
}