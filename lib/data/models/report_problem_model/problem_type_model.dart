class ProblemType {
  bool? success;
  String? message;
  String? type;
  List<ProblemCategory>? problemCategory;

  ProblemType({this.success, this.message, this.type, this.problemCategory});

  ProblemType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    type = json['type'];
    if (json['problem_category'] != null) {
      problemCategory = <ProblemCategory>[];
      json['problem_category'].forEach((v) {
        problemCategory!.add(ProblemCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['type'] = type;
    if (problemCategory != null) {
      data['problem_category'] =
          problemCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProblemCategory {
  String? name;

  ProblemCategory({this.name});

  ProblemCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
