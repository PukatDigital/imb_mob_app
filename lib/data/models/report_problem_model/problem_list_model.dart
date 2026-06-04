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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.problemListData != null) {
      data['data'] = this.problemListData!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subject'] = this.subject;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['creation'] = this.creation;
    return data;
  }
}