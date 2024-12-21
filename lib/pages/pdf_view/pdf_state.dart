part of 'pdf_cubit.dart';

class PdfState extends Equatable {
  final FormzSubmissionStatus status;
  final  File? Pfile;

  const PdfState({this.status = FormzSubmissionStatus.initial,this.Pfile});

  PdfState copyWith({FormzSubmissionStatus? status, File? Pfile}) {
    return PdfState(
        status: status ?? this.status,
        Pfile : Pfile ?? this.Pfile
    );
  }

  List<dynamic> get props => [status,Pfile];
}
