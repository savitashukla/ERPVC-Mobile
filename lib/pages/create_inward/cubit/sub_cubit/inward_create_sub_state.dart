part of 'inward_create_sub_cubit.dart';

class InwardCreateSubState extends Equatable {
  const InwardCreateSubState(
      {this.selectedDoc, this.documentData = const [], this.uploadedDocName,this.uploadedDocPath});

  final DocumentData? selectedDoc;
  final String? uploadedDocName;
  final String? uploadedDocPath;
  final List<DocumentData> documentData;

  InwardCreateSubState copyWith(
      {DocumentData? selectedDoc,
      List<DocumentData>? documentData,
      String? uploadedDocName,
      String? uploadedDocPath,
      }) {
    return InwardCreateSubState(
        selectedDoc: selectedDoc ?? this.selectedDoc,
        documentData: documentData ?? this.documentData,
        uploadedDocName: uploadedDocName ?? this.uploadedDocName,
        uploadedDocPath:uploadedDocPath ?? this.uploadedDocPath
    );
  }

  @override
  List<Object?> get props => [selectedDoc,uploadedDocName,uploadedDocPath];
}
