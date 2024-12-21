part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({this.email = const Email.pure(), this.apiStatus= FormzSubmissionStatus.initial});

  final Email? email;
  final FormzSubmissionStatus? apiStatus;

  ForgotPasswordState copyWith(
      {Email? email, FormzSubmissionStatus? apiStatus}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [email, apiStatus];
}
