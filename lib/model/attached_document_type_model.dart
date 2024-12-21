class DocumentTypeModel {
  List<DocumentData>? data;

  DocumentTypeModel({this.data});

  DocumentTypeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <DocumentData>[];
      json['data'].forEach((v) {
        data!.add(new DocumentData.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentData {
  String? id;
  String? name;
  String? fileName;

  DocumentData({this.id, this.name,this.fileName});

  DocumentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileName = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['filename'] = this.fileName;
    return data;
  }
}
