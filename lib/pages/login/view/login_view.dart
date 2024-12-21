import 'package:erpvc/helper/app_config.dart' as config;
import 'package:erpvc/helper/app_constant.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginCubit? loginCubit;

  @override
  void initState() {
    print('initState_Login');
    emailController.addListener(() {
      if (emailController.text.isNotEmpty) {
        print('email ${emailController.text}');
        context.read<LoginCubit>().onEmailChanged(value: emailController.text);
      }
    });
    passController.addListener(() {
      if (passController.text.isNotEmpty) {
        print('email ${passController.text}');
        context
            .read<LoginCubit>()
            .onPasswordChanged(value: passController.text);
      }
    });

    setUpFields();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  setUpFields() async {
    loginCubit = context.read<LoginCubit>();
    try {
      final FirebaseMessaging _fcm = FirebaseMessaging.instance;
      String? token = await _fcm.getToken();
      loginCubit!.firebaseToken(value: token!);
    } catch (E) {
      // firebasetoken="";
    }
    var prefs = await SharedPreferences.getInstance();
    bool? isRemembered = prefs.getBool(AppConstant.USER_REMEMBER_ME);
    if (kDebugMode) {
      print('rememberMe $isRemembered');
    }
    String? email, password;
    if (isRemembered != null && isRemembered) {
      email = prefs.getString(AppConstant.USER_EMAIL);
      password = prefs.getString(AppConstant.USER_PASSWORD);
    }
    if (email != null && password != null) {
      emailController.text = email.toString();
      passController.text = password.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.apiStatus.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.serverMessage),
              ));
            }
          },
          listenWhen: (p, c) {
            return p.apiStatus != c.apiStatus;
          },
          builder: (context, state) {
            return Container(
              height: config.AppConfig(context).appHeight(100),
              width: config.AppConfig(context).appWidth(100),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                          height: config.AppConfig(context).appHeight(70),
                          width: config.AppConfig(context).appWidth(100),
                          child: Image.asset(
                            'assets/img/background.png',
                            fit: BoxFit.cover,
                          )),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: config.AppConfig(context).appHeight(10),
                          ),
                          Center(
                            child: SizedBox(
                                child: SvgPicture.asset(
                              'assets/img/logo.svg',
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(
                            height: config.AppConfig(context).appHeight(10),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                config.AppConfig(context).appWidth(5),
                                0,
                                config.AppConfig(context).appWidth(5),
                                0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        config.AppConfig(context).appWidth(4)),
                                    topRight: Radius.circular(
                                        config.AppConfig(context)
                                            .appWidth(4)))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(2.5),
                                ),
                                Text(
                                  "Login",
                                  style: GoogleFonts.inter(
                                      color: config.AppColors().colorPrimary(1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: config.AppConfig(context)
                                          .appWidth(5)),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(3),
                                ),
                                Text(
                                  "Email or phone number",
                                  style: GoogleFonts.inter(
                                      color: state.email.isNotValid &&
                                              !state.email.isPure
                                          ? Color(0xffDC1919)
                                          : config.AppColors().textColor(1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: config.AppConfig(context)
                                          .appWidth(3.5)),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height:
                                          config.AppConfig(context).appWidth(4),
                                      width:
                                          config.AppConfig(context).appWidth(4),
                                      child: SvgPicture.asset(
                                        'assets/img/email.svg',
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          config.AppConfig(context).appWidth(2),
                                    ),
                                    SizedBox(
                                      height: config.AppConfig(context)
                                          .appHeight(6),
                                      width: config.AppConfig(context)
                                          .appWidth(75),
                                      child: TextFormField(
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                  child: Divider(
                                    color: state.email.isNotValid &&
                                            !state.email.isPure
                                        ? Color(0xffDC1919)
                                        : Color(0xffD3D8DD),
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(3),
                                ),
                                Text(
                                  "Password",
                                  style: GoogleFonts.inter(
                                      color: state.password.isNotValid &&
                                              !state.password.isPure
                                          ? Color(0xffDC1919)
                                          : config.AppColors().textColor(1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: config.AppConfig(context)
                                          .appWidth(3.5)),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height:
                                          config.AppConfig(context).appWidth(4),
                                      width:
                                          config.AppConfig(context).appWidth(4),
                                      child: SvgPicture.asset(
                                        'assets/img/lock.svg',
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          config.AppConfig(context).appWidth(2),
                                    ),
                                    SizedBox(
                                      height: config.AppConfig(context)
                                          .appHeight(6),
                                      width: config.AppConfig(context)
                                          .appWidth(75),
                                      child: TextFormField(
                                        controller: passController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        obscureText: state.showPassword,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<LoginCubit>().showPassword(
                                            show: !state.showPassword);
                                      },
                                      child: SizedBox(
                                        height: config.AppConfig(context)
                                            .appWidth(6),
                                        width: config.AppConfig(context)
                                            .appWidth(6),
                                        child: state.showPassword
                                            ? SvgPicture.asset(
                                                "assets/img/visible_eye.svg")
                                            : Icon(
                                                Icons.visibility_off_outlined,
                                                color: config.AppColors()
                                                    .colorPrimary(1),
                                                size: config.AppConfig(context)
                                                    .appWidth(6),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                  child: Divider(
                                    color: state.password.isNotValid &&
                                            !state.password.isPure
                                        ? Color(0xffDC1919)
                                        : Color(0xffD3D8DD),
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(2),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: config.AppConfig(context)
                                              .appWidth(2)),
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<LoginCubit>()
                                              .isRememberMe();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Checkbox(
                                                  checkColor: Colors.white,
                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    return config.AppColors()
                                                        .colorPrimary(1);
                                                  }),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                  value: state.rememberMe,
                                                  activeColor:
                                                      config.AppColors()
                                                          .colorPrimary(1),
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 2.0,
                                                        color:
                                                            config.AppColors()
                                                                .colorPrimary(
                                                                    1)),
                                                  ),
                                                  onChanged: (val) {
                                                    context
                                                        .read<LoginCubit>()
                                                        .isRememberMe();
                                                  }),
                                            ),
                                            SizedBox(
                                                width: config.AppConfig(context)
                                                    .appWidth(4)),
                                            Text(
                                              'Remember me',
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      config.AppConfig(context)
                                                          .appHeight(1.7),
                                                  color: config.AppColors()
                                                      .textColor(1),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigatorKey.currentState!
                                            .pushNamed("/ForgotPassword");
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.roboto(
                                            fontSize: config.AppConfig(context)
                                                .appHeight(1.7),
                                            color: config.AppColors()
                                                .colorPrimary(1),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(2),
                                ),
                                InkWell(
                                  onTap: () {
                                    state.status
                                        ? context.read<LoginCubit>().doLogin()
                                        : () {};
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        config.AppConfig(context).appWidth(1),
                                        config.AppConfig(context).appHeight(3),
                                        config.AppConfig(context).appWidth(1),
                                        config.AppConfig(context).appHeight(3)),
                                    child: state.apiStatus.isInProgress
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: config.AppColors()
                                                    .colorPrimary(1)),
                                          )
                                        : Container(
                                            height: config.AppConfig(context)
                                                .appHeight(6.5),
                                            width: config.AppConfig(context)
                                                .appWidth(100),
                                            decoration: BoxDecoration(
                                              gradient: state.status
                                                  ? LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      colors: [
                                                        config.AppColors()
                                                            .colorPrimary(1),
                                                        config.AppColors()
                                                            .colorPrimary(1),
                                                        config.AppColors()
                                                            .colorPrimary(1),
                                                      ],
                                                    )
                                                  : LinearGradient(colors: [
                                                      Theme.of(context)
                                                          .focusColor,
                                                      Theme.of(context)
                                                          .focusColor,
                                                    ]),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      config.AppConfig(context)
                                                          .appHeight(0.5)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Login',
                                                style: GoogleFonts.roboto(
                                                    fontSize: config.AppConfig(
                                                            context)
                                                        .appHeight(2.5),
                                                    color: config.AppColors()
                                                        .colorText(1),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
