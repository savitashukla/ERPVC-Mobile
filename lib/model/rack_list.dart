class RackList {
  bool? status;
  String? message;
  List<RackData>? data;

  RackList({this.status, this.message, this.data});

  RackList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RackData>[];
      json['data'].forEach((v) {
        data!.add(new RackData.fromJson(v));
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

class RackData {
  String? id;
  String? warehouseId;
  String? locationName;
  String? locationCode;
  String? locationType;
  String? capacity;
  String? note;
  String? status;

  RackData(
      {this.id,
        this.warehouseId,
        this.locationName,
        this.locationCode,
        this.locationType,
        this.capacity,
        this.note,
        this.status});

  RackData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseId = json['warehouse_id'];
    locationName = json['location_name'];
    locationCode = json['location_code'];
    locationType = json['location_type'];
    capacity = json['capacity'];
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_id'] = this.warehouseId;
    data['location_name'] = this.locationName;
    data['location_code'] = this.locationCode;
    data['location_type'] = this.locationType;
    data['capacity'] = this.capacity;
    data['note'] = this.note;
    data['status'] = this.status;
    return data;
  }
}