class ZodiacSignsModel {
  Data? data;
  String? type;

  ZodiacSignsModel({this.data, this.type});

  ZodiacSignsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Data {
  bool? success;
  String? message;
  List<ZodiacSigns>? zodiacSigns;

  Data({this.success, this.message, this.zodiacSigns});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['zodiac_signs'] != null) {
      zodiacSigns = <ZodiacSigns>[];
      json['zodiac_signs'].forEach((v) {
        zodiacSigns!.add(ZodiacSigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (zodiacSigns != null) {
      data['zodiac_signs'] = zodiacSigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZodiacSigns {
  String? name;

  ZodiacSigns({this.name});

  ZodiacSigns.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
