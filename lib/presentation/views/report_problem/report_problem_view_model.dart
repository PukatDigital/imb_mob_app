import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/report_problem_model/problem_detail_model.dart';
import 'package:ideal_marriage_bureau/data/models/report_problem_model/problem_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/report_problem_model/problem_type_model.dart';

import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_view_model.dart';
class GetReportProblem extends BaseViewModel {
  ProblemType problemTypeModel = ProblemType();
  ProblemList problemListModel = ProblemList();
ProblemDetailModel profileDetailsModel = ProblemDetailModel();


  void getProblemTypes(ErrorResult result) async {
    apiResponse = Loading();
    apiResponse = await api.getProblemType();
    apiResponse.fold<ProblemType>(  // ← generic type matches
      onSuccess: (success) {
        problemTypeModel = success;
        notifyListeners();
      },
      onError: result.onError,
    );
  }
  Future<void> getProblemList(
      Result result, {
        required String searchName,
      }) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getProblemList({"search": searchName});

    apiResponse.fold<ProblemList>(
      onSuccess: (res) {
        problemListModel = res;
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        result.onError(err);
      },
    );
  }

  void createReportProblem(
      Map<String, dynamic> data, Result result) async
  {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.createReportProblem(data);

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

  Future<void> getProblemDetail(Result result, {required String problemId}) async {
    apiResponse = Loading();
    notifyListeners();

    apiResponse = await api.getProblemDetails({"problem_id": problemId});

    apiResponse.fold<ProblemDetailModel>(
      onSuccess: (res) {
        profileDetailsModel = res;
        d("✅ Profile Details: ${res.toJson()}");
        notifyListeners();
        result.onSuccess("success");
      },
      onError: (err) {
        d("❌ Profile Details error: $err");
        result.onError(err);
      },
    );
  }
  void searchReportProblem(Map<String, dynamic> data, Result result) async {
    d(data);

    apiResponse = Loading();
    notifyListeners(); // important if using Provider

    apiResponse = await api.getProblemList(data);

    apiResponse.fold(
      onSuccess: result.onSuccess,
      onError: result.onError,
    );
  }

}