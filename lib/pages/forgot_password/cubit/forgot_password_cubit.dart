import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/model/email.dart';
import 'package:formz/formz.dart';

import '../../../api_hleper/api_helper.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState());

  onEmailChanged({String? value}) {
    emit(state.copyWith(email: Email.dirty(value!)));
  }

  Future<void> passwordForget(String? emailId) async {
    emit(state.copyWith(apiStatus: FormzSubmissionStatus.inProgress));
    Map<String, dynamic>? response =
        await APIHelper().passwordForget("$emailId");
    emit(state.copyWith(apiStatus: FormzSubmissionStatus.success));

    if (response != null) {
    } else {}
  }
}
