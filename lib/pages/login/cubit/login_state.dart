part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = false,
      this.rememberMe = false,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.showPassword = true,
      this.isFromSharedPref = false,
      this.serverMessage = '',
      this.apiStatus = FormzSubmissionStatus.initial,
      this.deviceToken= '',
      this.firebasetoken= '',
      this.loginValue = '',
      this.versionNum = ''});

  final bool rememberMe;
  final bool status;
  final Email email;
  final Password password;
  final bool showPassword;
  final bool isFromSharedPref;
  final String serverMessage;
  final FormzSubmissionStatus apiStatus;
  final String? deviceToken;
  final String? firebasetoken;
  final String? loginValue;
  final String? versionNum;

  LoginState copyWith({
    bool? rememberMe,
    bool? status,
    Email? email,
    String? deviceToken,
    String? firebasetoken,
    Password? password,
    bool? isFromSharedPref,
    String? serverMessage,
    FormzSubmissionStatus? apiStatus,
    bool? showPassword,
    String? loginValue,
    String? versionNum,
  }) {
    return LoginState(
        isFromSharedPref: isFromSharedPref ?? this.isFromSharedPref,
        deviceToken: deviceToken ?? this.deviceToken,
      firebasetoken: firebasetoken ?? this.firebasetoken,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe,
        showPassword: showPassword ?? this.showPassword,
        status: status ?? this.status,
        email: email ?? this.email,
        serverMessage: serverMessage ?? this.serverMessage,
        apiStatus: apiStatus ?? this.apiStatus,
        loginValue: loginValue ?? this.loginValue,
        versionNum: versionNum ?? this.versionNum,
    );
  }

  @override
  List<Object?> get props => [
        deviceToken,
    firebasetoken,
        email,
        password,
        showPassword,
        status,
        isFromSharedPref,
        rememberMe,
        apiStatus,
        serverMessage,
        loginValue,
        versionNum
      ];
}
