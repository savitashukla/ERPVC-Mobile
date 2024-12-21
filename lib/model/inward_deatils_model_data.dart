class InwardDeatilsModelData {
  bool? status;
  String? message;
  Data? data;

  InwardDeatilsModelData({this.status, this.message, this.data});

  InwardDeatilsModelData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? mrirNo;
  String? mrirDate;
  String? inwardNo;
  String? inwardDate;
  String? vendorId;
  String? invoiceNo;
  String? invoiceDate;
  String? amount;
  String? unitNo;
  String? grRrNo;
  String? gtRrDate;
  String? transporter;
  String? vehicleNo;
  String? freightCost;
  String? perUnit;
  String? cenvatPaper;
  String? type;
  String? userRole;
  String? createdBy;
  String? createdAt;
  String? isDeleted;
  String? updatedAt;
  String? rackStatus;
  String? partyname;
  String? partyid;
  String? transporterName;
  List<Itemslist>? itemslist;
  List<Attachmentlist>? attachmentlist;
  int? rackAssign;

  Data(
      {this.id,
        this.mrirNo,
        this.mrirDate,
        this.inwardNo,
        this.inwardDate,
        this.vendorId,
        this.invoiceNo,
        this.invoiceDate,
        this.amount,
        this.unitNo,
        this.grRrNo,
        this.gtRrDate,
        this.transporter,
        this.vehicleNo,
        this.freightCost,
        this.perUnit,
        this.cenvatPaper,
        this.type,
        this.userRole,
        this.createdBy,
        this.createdAt,
        this.isDeleted,
        this.updatedAt,
        this.rackStatus,
        this.partyname,
        this.partyid,
        this.transporterName,
        this.itemslist,
        this.attachmentlist,
        this.rackAssign});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mrirNo = json['mrir_no'];
    mrirDate = json['mrir_date'];
    inwardNo = json['inward_no'];
    inwardDate = json['inward_date'];
    vendorId = json['vendor_id'];
    invoiceNo = json['invoice_no'];
    invoiceDate = json['invoice_date'];
    amount = json['amount'];
    unitNo = json['unit_no'];
    grRrNo = json['gr_rr_no'];
    gtRrDate = json['gt_rr_date'];
    transporter = json['transporter'];
    vehicleNo = json['vehicle_no'];
    freightCost = json['freight_cost'];
    perUnit = json['per_unit'];
    cenvatPaper = json['cenvat_paper'];
    type = json['type'];
    userRole = json['user_role'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    rackStatus = json['rack_status'];
    partyname = json['partyname'];
    partyid = json['partyid'];
    transporterName = json['transporter_name'];
    if (json['itemslist'] != null) {
      itemslist = <Itemslist>[];
      json['itemslist'].forEach((v) {
        itemslist!.add(new Itemslist.fromJson(v));
      });
    }
    if (json['attachmentlist'] != null) {
      attachmentlist = <Attachmentlist>[];
      json['attachmentlist'].forEach((v) {
        attachmentlist!.add(new Attachmentlist.fromJson(v));
      });
    }
    rackAssign = json['rack_assign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mrir_no'] = this.mrirNo;
    data['mrir_date'] = this.mrirDate;
    data['inward_no'] = this.inwardNo;
    data['inward_date'] = this.inwardDate;
    data['vendor_id'] = this.vendorId;
    data['invoice_no'] = this.invoiceNo;
    data['invoice_date'] = this.invoiceDate;
    data['amount'] = this.amount;
    data['unit_no'] = this.unitNo;
    data['gr_rr_no'] = this.grRrNo;
    data['gt_rr_date'] = this.gtRrDate;
    data['transporter'] = this.transporter;
    data['vehicle_no'] = this.vehicleNo;
    data['freight_cost'] = this.freightCost;
    data['per_unit'] = this.perUnit;
    data['cenvat_paper'] = this.cenvatPaper;
    data['type'] = this.type;
    data['user_role'] = this.userRole;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['rack_status'] = this.rackStatus;
    data['partyname'] = this.partyname;
    data['partyid'] = this.partyid;
    data['transporter_name'] = this.transporterName;
    if (this.itemslist != null) {
      data['itemslist'] = this.itemslist!.map((v) => v.toJson()).toList();
    }
    if (this.attachmentlist != null) {
      data['attachmentlist'] =
          this.attachmentlist!.map((v) => v.toJson()).toList();
    }
    data['rack_assign'] = this.rackAssign;
    return data;
  }
}

class Itemslist {
  String? id;
  String? inwardId;
  String? itemId;
  String? lfNo;
  String? poNo;
  String? unit;
  String? packageType;
  String? packageQuantity;
  String? packageCapacity;
  String? onBillQty;
  String? onRecieveQty;
  String? onShortQty;
  String? qcRfNo;
  String? aAdR;
  String? quantityApproved;
  String? netTotalCost;
  String? manufacturingDate;
  String? expiryDate;
  String? coaOption;
  String? batchNumber;
  String? createdAt;
  String? updatedAt;
  String? itemName;

  Itemslist(
      {this.id,
        this.inwardId,
        this.itemId,
        this.lfNo,
        this.poNo,
        this.unit,
        this.packageType,
        this.packageQuantity,
        this.packageCapacity,
        this.onBillQty,
        this.onRecieveQty,
        this.onShortQty,
        this.qcRfNo,
        this.aAdR,
        this.quantityApproved,
        this.netTotalCost,
        this.manufacturingDate,
        this.expiryDate,
        this.coaOption,
        this.batchNumber,
        this.createdAt,
        this.updatedAt,
        this.itemName});

  Itemslist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inwardId = json['inward_id'];
    itemId = json['item_id'];
    lfNo = json['lf_no'];
    poNo = json['po_no'];
    unit = json['unit'];
    packageType = json['package_type'];
    packageQuantity = json['package_quantity'];
    packageCapacity = json['package_capacity'];
    onBillQty = json['on_bill_qty'];
    onRecieveQty = json['on_recieve_qty'];
    onShortQty = json['on_short_qty'];
    qcRfNo = json['qc_rf_no'];
    aAdR = json['a_ad_r'];
    quantityApproved = json['quantity_approved'];
    netTotalCost = json['net_total_cost'];
    manufacturingDate = json['manufacturing_date'];
    expiryDate = json['expiry_date'];
    coaOption = json['coa_option'];
    batchNumber = json['batch_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inward_id'] = this.inwardId;
    data['item_id'] = this.itemId;
    data['lf_no'] = this.lfNo;
    data['po_no'] = this.poNo;
    data['unit'] = this.unit;
    data['package_type'] = this.packageType;
    data['package_quantity'] = this.packageQuantity;
    data['package_capacity'] = this.packageCapacity;
    data['on_bill_qty'] = this.onBillQty;
    data['on_recieve_qty'] = this.onRecieveQty;
    data['on_short_qty'] = this.onShortQty;
    data['qc_rf_no'] = this.qcRfNo;
    data['a_ad_r'] = this.aAdR;
    data['quantity_approved'] = this.quantityApproved;
    data['net_total_cost'] = this.netTotalCost;
    data['manufacturing_date'] = this.manufacturingDate;
    data['expiry_date'] = this.expiryDate;
    data['coa_option'] = this.coaOption;
    data['batch_number'] = this.batchNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['item_name'] = this.itemName;
    return data;
  }
}

class Attachmentlist {
  String? typeId;
  String? type;
  String? attachment;

  Attachmentlist({this.typeId, this.type, this.attachment});

  Attachmentlist.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    type = json['type'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type'] = this.type;
    data['attachment'] = this.attachment;
    return data;
  }
}
