class InventoryList {
  bool? status;
  String? message;
  List<DataInventory>? data;

  InventoryList({this.status, this.message, this.data});

  InventoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataInventory>[];
      json['data'].forEach((v) {
        data!.add(new DataInventory.fromJson(v));
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

class DataInventory {
  String? id;
  String? pname;
  String? pdescription;
  String? fileName;
  String? quantity;

  DataInventory({this.id, this.pname, this.pdescription, this.fileName, this.quantity});

  DataInventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pname = json['pname'];
    pdescription = json['pdescription'];
    fileName = json['file_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pname'] = this.pname;
    data['pdescription'] = this.pdescription;
    data['file_name'] = this.fileName;
    data['quantity'] = this.quantity;
    return data;
  }
}