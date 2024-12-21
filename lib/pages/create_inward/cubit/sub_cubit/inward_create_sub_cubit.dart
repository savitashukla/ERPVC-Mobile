import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../helper/helper.dart';
import '../../../../model/attached_document_type_model.dart';

part 'inward_create_sub_state.dart';

class InwardCreateSubCubit extends Cubit<InwardCreateSubState> {
  InwardCreateSubCubit({this.selectedDoc, this.uploadedDocName})
      : super(InwardCreateSubState(
            selectedDoc: selectedDoc, uploadedDocName: uploadedDocName));
  DocumentData? selectedDoc;
  String? uploadedDocName;

  onChangeAttachedDoc(DocumentData? selectedDoc) {
    emit(state.copyWith(selectedDoc: selectedDoc));
  }

  selectFile() async {

    double _sizeKbs = 0;
    final int maxSizeKbs = 1024*20;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
      if(result != null) {
        final size = result.files.first.size;
        _sizeKbs = size/1024;
        print("size of file $_sizeKbs");
        if(_sizeKbs > maxSizeKbs) {
          Helper.showToast('size should be less than $maxSizeKbs Kb');
        }
        else {
          List<File> files = result.paths.map((path) => File(path!)).toList();
          String fileName = result.files.first.name;
          String filePath = result.files.first.path!;
          emit(
              state.copyWith(uploadedDocName: fileName, uploadedDocPath: filePath));
          print("fileName ${fileName}");
        }
      }
    else {
      // User canceled the picker
    }
  }
}
