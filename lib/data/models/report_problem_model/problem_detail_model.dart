import 'dart:io';

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.detail != null) {
      data['data'] = this.detail!.toJson(); // ← 'data'
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subject'] = this.subject;
    data['problem_category'] = this.problemCategory;
    data['description'] = this.description;
    data['remarks'] = this.remarks;
    data['attachment'] = this.attachment;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['posting_date'] = this.postingDate;
    data['posting_time'] = this.postingTime;
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['reported_by'] = this.reportedBy;
    data['attachment_url'] = this.attachmentUrl;
    return data;
  }
}
