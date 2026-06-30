class ProblemList {
  String? type;
  bool? success;
  String? message;
  List<ProblemListData>? problemListData;

  ProblemList({this.type, this.success, this.message, this.problemListData});

  ProblemList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {                          // ✅ Fixed: 'ProblemListData' → 'data'
      problemListData = <ProblemListData>[];
      json['data'].forEach((v) {
        problemListData!.add(ProblemListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['success'] = success;
    data['message'] = message;
    if (problemListData != null) {
      data['data'] = problemListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProblemListData {
  String? name;
  String? subject;
  String? status;
  String? priority;
  String? creation;

  ProblemListData(
      {this.name, this.subject, this.status, this.priority, this.creation});

  ProblemListData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subject = json['subject'];
    status = json['status'];
    priority = json['priority'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['subject'] = subject;
    data['status'] = status;
    data['priority'] = priority;
    data['creation'] = creation;
    return data;
  }
}