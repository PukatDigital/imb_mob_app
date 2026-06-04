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
        problemCategory!.add(new ProblemCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.problemCategory != null) {
      data['problem_category'] =
          this.problemCategory!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
