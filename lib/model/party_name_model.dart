class PartyModel {
  bool? status;
  String? message;
  List<PartyData>? data;

  PartyModel({this.status, this.message, this.data});

  PartyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PartyData>[];
      json['data'].forEach((v) {
        data!.add(new PartyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartyData {
  String? userid;
  String? company;

  PartyData({this.userid, this.company});

  PartyData.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['company'] = this.company;
    return data;
  }
}
