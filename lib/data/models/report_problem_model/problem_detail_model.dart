
class ProblemDetailModel {
  String? type;
  bool? success;
  String? message;
  Detail? detail;

  ProblemDetailModel({this.type, this.success, this.message, this.detail});

  ProblemDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    success = json['success'];
    message = json['message'];
    detail = json['data'] != null ? Detail.fromJson(json['data']) : null; // ← 'data'
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['success'] = success;
    data['message'] = message;
    if (detail != null) {
      data['data'] = detail!.toJson(); // ← 'data'
    }
    return data;
  }
}

class Detail {
  String? name;
  String? subject;
  String? problemCategory;
  String? description;
  String? remarks;        // ← was Null?
  String? attachment;
  String? status;
  String? priority;
  String? postingDate;
  String? postingTime;
  String? profileId;
  String? userId;
  String? reportedBy;
  String? attachmentUrl;

  Detail(
      {this.name,
        this.subject,
        this.problemCategory,
        this.description,
        this.remarks,
        this.attachment,
        this.status,
        this.priority,
        this.postingDate,
        this.postingTime,
        this.profileId,
        this.userId,
        this.reportedBy,
        this.attachmentUrl});

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subject = json['subject'];
    problemCategory = json['problem_category'];
    description = json['description'];
    remarks = json['remarks'];
    attachment = json['attachment'];
    status = json['status'];
    priority = json['priority'];
    postingDate = json['posting_date'];
    postingTime = json['posting_time'];
    profileId = json['profile_id'];
    userId = json['user_id'];
    reportedBy = json['reported_by'];
    attachmentUrl = json['attachment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['subject'] = subject;
    data['problem_category'] = problemCategory;
    data['description'] = description;
    data['remarks'] = remarks;
    data['attachment'] = attachment;
    data['status'] = status;
    data['priority'] = priority;
    data['posting_date'] = postingDate;
    data['posting_time'] = postingTime;
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['reported_by'] = reportedBy;
    data['attachment_url'] = attachmentUrl;
    return data;
  }
}
