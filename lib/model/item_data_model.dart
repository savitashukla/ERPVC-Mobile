class ItemDataModel {
  String? id;
  String? itemId;
  String? inwardId;
  String? lfNo;
  String? poNo;
  String? unit;
  String? onBillQty;
  String? onRecieveQty;
  String? onShortQty;
  String? manufacturingDate;
  String? expiryDate;
  String? batchNumber;
  String? packageType;
  String? packageQuantity;
  String? packageCapacity;

  ItemDataModel({
    this.id,
    this.inwardId,
    this.itemId,
    this.lfNo,
    this.poNo,
    this.unit,
    this.onBillQty,
    this.onRecieveQty,
    this.manufacturingDate,
    this.expiryDate,
    this.onShortQty,
    this.batchNumber,
    this.packageType,
    this.packageQuantity,
    this.packageCapacity,
  });

  ItemDataModel.fromJson(Map<String, dynamic> json) {
    itemId = json['id'];
    itemId = json['inward_id'];
    itemId = json['item_id'];
    lfNo = json['lf_no'];
    poNo = json['po_no'];
    unit = json['unit'];
    onBillQty = json['on_bill_qty'];
    onRecieveQty = json['on_recieve_qty'];
    onShortQty = json['on_short_qty'];
    manufacturingDate = json['manufacturing_date'];
    expiryDate = json['expiry_date'];
    batchNumber = json['batch_number'];
    packageType = json['package_type'];
    packageQuantity = json['package_quantity'];
    packageCapacity = json['package_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['lf_no'] = this.lfNo;
    data['po_no'] = this.poNo;
    data['unit'] = this.unit;
    data['on_bill_qty'] = this.onBillQty;
    data['on_recieve_qty'] = this.onRecieveQty;
    data['on_short_qty'] = this.onShortQty;
    data['manufacturing_date'] = this.manufacturingDate;
    data['expiry_date'] = this.expiryDate;
    data['batch_number'] = this.batchNumber;
    data['package_type'] = this.packageType;
    data['package_quantity'] = this.packageQuantity;
    data['package_capacity'] = this.packageCapacity;
    return data;
  }
}
