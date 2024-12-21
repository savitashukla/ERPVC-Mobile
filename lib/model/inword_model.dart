class InwardModelData {
  bool? status;
  String? message;
  int? totalrows;
  List<InwardData>? data;

  InwardModelData({this.status, this.message, this.totalrows, this.data});

  InwardModelData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalrows = json['totalrows'];
    if (json['data'] != null) {
      data = <InwardData>[];
      json['data'].forEach((v) {
        data!.add(new InwardData.fromJson(v));
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

class InwardData {
  String? id;
  String? inwardNo;
  String? no_of_products;
  String? inwardDate;
  String? vendorId;
  String? invoiceNo;
  String? invoiceDate;
  String? poNo;
  String? poDate;
  String? transporter;
  String? vehicleNo;
  String? grRrNo;
  String? gtRrDate;
  String? type;
  String? userRole;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? partyname;
  int? rackflag;

  InwardData(
      {this.id,
        this.inwardNo,
        this.no_of_products,
        this.inwardDate,
        this.vendorId,
        this.invoiceNo,
        this.invoiceDate,
        this.poNo,
        this.poDate,
        this.transporter,
        this.vehicleNo,
        this.grRrNo,
        this.gtRrDate,
        this.type,
        this.userRole,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.partyname,
        this.rackflag});

  InwardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inwardNo = json['inward_no'];
    no_of_products = json['no_of_products'];
    inwardDate = json['inward_date'];
    vendorId = json['vendor_id'];
    invoiceNo = json['invoice_no'];
    invoiceDate = json['invoice_date'];
    poNo = json['po_no'];
    poDate = json['po_date'];
    transporter = json['transporter'];
    vehicleNo = json['vehicle_no'];
    grRrNo = json['gr_rr_no'];
    gtRrDate = json['gt_rr_date'];
    type = json['type'];
    userRole = json['user_role'];
    createdBy = json['created_by'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at'];
    partyname = json['partyname'];
    rackflag = json['rackflag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inward_no'] = this.inwardNo;
    data['no_of_products'] = this.no_of_products;
    data['inward_date'] = this.inwardDate;
    data['vendor_id'] = this.vendorId;
    data['invoice_no'] = this.invoiceNo;
    data['invoice_date'] = this.invoiceDate;
    data['po_no'] = this.poNo;
    data['po_date'] = this.poDate;
    data['transporter'] = this.transporter;
    data['vehicle_no'] = this.vehicleNo;
    data['gr_rr_no'] = this.grRrNo;
    data['gt_rr_date'] = this.gtRrDate;
    data['type'] = this.type;
    data['user_role'] = this.userRole;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['partyname'] = this.partyname;
    data['rackflag'] = this.rackflag;
    return data;
  }
}
