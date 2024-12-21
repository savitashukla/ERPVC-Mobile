import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/helper/app_constant.dart';
import 'package:erpvc/model/email.dart';
import 'package:erpvc/model/password.dart';
import 'package:erpvc/model/user_model.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit({this.authenticationRepository, this.userRepository})
      : super(const LoginState()) {
    checkRememberMe();
  }

  AuthenticationRepository? authenticationRepository;
  UserRepository? userRepository;

  onDeviceTokenChange({String? deviceToken}) {
    debugPrint('deviceTokenLogin $deviceToken');
    emit(state.copyWith(deviceToken: deviceToken));
  }

  void checkRememberMe() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isRemembered = prefs.getBool(AppConstant.USER_REMEMBER_ME);
    debugPrint("checkRememberMe ${isRemembered}");
    if (isRemembered != null && isRemembered) {
      var email = prefs.getString(AppConstant.USER_EMAIL);
      var password = prefs.getString(AppConstant.USER_PASSWORD);
      emit(state.copyWith(
          rememberMe: true,
          password: Password.dirty(password!),
          email: Email.dirty(email!)));
      onEmailChanged(value: email);
      onPasswordChanged(value: password);
    }
  }

  isRememberMe({bool? isRememberMe}) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  showPassword({bool? show}) {
    emit(state.copyWith(
      showPassword: show,
      status: Formz.validate([state.password, state.email]),
    ));
  }

  void onEmailChanged({String? value}) {
    emit(state.copyWith(
        email: Email.dirty(value.toString()),
        status:
            Formz.validate([Email.dirty(value.toString()), state.password])));
  }

  void firebaseToken({String? value}) {
    emit(state.copyWith(
        firebasetoken:value));
  }

  void onPasswordChanged({String? value}) {
    emit(state.copyWith(
        password: Password.dirty(value.toString()),
        status:
            Formz.validate([Password.dirty(value.toString()), state.email])));
  }

  void doLogin() async {


    // try {
    emit(state.copyWith(apiStatus: FormzSubmissionStatus.inProgress));
    var map = <String, dynamic>{};
    map['email'] = state.email.value;
    map['password'] = state.password.value;
    map['device_token'] = state.deviceToken;

    map['firebase_token'] = state.firebasetoken??'';
    print("map $map");
    http.Response response = await authenticationRepository!.logIn(data: map);

    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      String message = userModel.message!;
      if (userModel.status!) {
        userRepository!.setCurrentUser(response.body).then((value) async {
          authenticationRepository!.controller
              .add(AuthenticationStatus.authenticated);
          emit(state.copyWith(apiStatus: FormzSubmissionStatus.success));
          var prefs = await SharedPreferences.getInstance();
          prefs.setString("accessToken", "${userModel.data!.accessToken}");

          if (state.rememberMe) {
            prefs.setBool(AppConstant.USER_REMEMBER_ME, state.rememberMe);
            prefs.setString(AppConstant.USER_EMAIL, state.email.value);
            prefs.setString(AppConstant.USER_PASSWORD, state.password.value);
          }
        });
      } else if (userModel.status == false) {
        emit(state.copyWith(
            apiStatus: FormzSubmissionStatus.failure, serverMessage: message));
      } else {
        emit(state.copyWith(
            apiStatus: FormzSubmissionStatus.failure,
            serverMessage: 'Something went wrong...'));
      }
    } else if (response.statusCode == 404) {
      emit(state.copyWith(
          apiStatus: FormzSubmissionStatus.failure,
          serverMessage: jsonDecode(response.body)['message']));
    }
    // } catch (e) {
    //   emit(state.copyWith(
    //       apiStatus: FormzSubmissionStatus.failure,
    //       serverMessage: 'Something went wrong...'));
    // }
  }
}
