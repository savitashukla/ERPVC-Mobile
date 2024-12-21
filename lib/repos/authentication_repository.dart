import 'dart:async';
import 'package:erpvc/api_hleper/api_helper.dart';
import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/app_config.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

final navigatorKey = GlobalKey<NavigatorState>();

class AuthenticationRepository {
  final controller = StreamController<AuthenticationStatus>();
  final UserRepository _userRepository = UserRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    final user = await _userRepository.getUser();
    if (user != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* controller.stream;
  }

  Future<dynamic> logIn({
    required Map<String, dynamic> data,
  }) async {
    const url = 'user/login';
    final response = await APIHelper().post(endpoint: url, bodyData: data);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

  void dispose() => controller.close();

  Future showAlertDialog(BuildContext context) async {
    AlertDialog alert = AlertDialog(
      elevation: 24,
      content: const Text("Do you want to Logout?"),

      actions: [
        TextButton(
            onPressed: () {
              logOut();
            },



            child: Text("Yes",
                style: GoogleFonts.inter(
                    color: AppColors().textColor(1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400))),

        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },

            child: Text("No",
                style: GoogleFonts.inter(
                    color: AppColors().textColor(1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400))),

      ],
    );
    await showDialog(context: context, builder: (_) => alert);
  }

  logOut() {
    _userRepository.clearuserData();
    print('app:-unauthenticated_logOut');
    controller.add(AuthenticationStatus.unauthenticated);
  }
}
