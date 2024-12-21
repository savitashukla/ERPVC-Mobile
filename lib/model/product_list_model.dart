class ProductListModel {
  bool? status;
  String? message;
  int? totalrows;
  List<ProductData>? data;

  ProductListModel({this.status, this.message, this.totalrows, this.data});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalrows = json['totalrows'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalrows'] = this.totalrows;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? id;
  String? description;
  String? unit;
  String? longDescription;
  String? productname;

  ProductData(
      {this.id,
      this.description,
      this.unit,
      this.longDescription,
      this.productname});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    unit = json['unit'];
    longDescription = json['long_description'];
    productname = json['productname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['long_description'] = this.longDescription;
    data['productname'] = this.productname;
    return data;
  }
}
