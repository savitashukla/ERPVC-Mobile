import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  PdfCubit() : super(PdfState());

  onPdfLoad({File? pFile,FormzSubmissionStatus? status}){
    emit(state.copyWith(
      status: status,
      Pfile: pFile
    ));
    debugPrint("pfile -->>$pFile");
  }

}
