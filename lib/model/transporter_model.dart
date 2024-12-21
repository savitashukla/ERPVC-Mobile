class TransporterModel {
  bool? status;
  String? message;
  List<DataTransporterModel>? data;

  TransporterModel({this.status, this.message, this.data});

  TransporterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTransporterModel>[];
      json['data'].forEach((v) {
        data!.add(new DataTransporterModel.fromJson(v));
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

class DataTransporterModel {
  String? id;
  String? tName;
  String? tAddress;
  String? tNumber;
  String? status;
  String? createdAt;
  Null? updatedAt;

  DataTransporterModel(
      {this.id,
        this.tName,
        this.tAddress,
        this.tNumber,
        this.status,
        this.createdAt,
        this.updatedAt});

  DataTransporterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tName = json['t_name'];
    tAddress = json['t_address'];
    tNumber = json['t_number'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['t_name'] = this.tName;
    data['t_address'] = this.tAddress;
    data['t_number'] = this.tNumber;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}