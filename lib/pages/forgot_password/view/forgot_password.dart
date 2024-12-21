import 'package:erpvc/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:erpvc/helper/app_config.dart' as config;
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => ForgotPasswordCubit(),
        child: ForgotPassword(),
      );
    });
  }

  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordCubit? forgetPasswordCubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    forgetPasswordCubit = context.read<ForgotPasswordCubit>();
  }


  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {},
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
                            height: config.AppConfig(context).appHeight(4),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: config.AppConfig(context).appWidth(1),
                              ),
                              InkWell(
                                onTap: () {
                                  navigatorKey.currentState!.pop();
                                },
                                child: Icon(
                                  Icons.keyboard_backspace,
                                  color: Colors.white,
                                  size: config.AppConfig(context).appWidth(10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: config.AppConfig(context).appHeight(2),
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
                                      config.AppConfig(context).appHeight(3),
                                ),
                                Text(
                                  "Forgot Password",
                                  style: GoogleFonts.inter(
                                      color: config.AppColors().colorPrimary(1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: config.AppConfig(context)
                                          .appWidth(5)),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(1),
                                ),
                                Text(
                                  "Enter registered email address",
                                  style: GoogleFonts.inter(
                                      color: config.AppColors().textColor(1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: config.AppConfig(context)
                                          .appWidth(4)),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(4),
                                ),
                                Text(
                                  "Email",
                                  style: GoogleFonts.inter(
                                      color: state.email!.isNotValid &&
                                              !state.email!.isPure
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
                                        onChanged: (value) {
                                          context
                                              .read<ForgotPasswordCubit>()
                                              .onEmailChanged(value: value);
                                        },
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
                                    color: state.email!.isNotValid &&
                                            !state.email!.isPure
                                        ? Color(0xffDC1919)
                                        : Color(0xffD3D8DD),
                                    thickness: 1,
                                  ),
                                ),



                                /* TextFormField(
                                  // controller: emailController,
                                  onChanged: (value) {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .onEmailChanged(value: value);
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    errorText: state.email!.isNotValid &&
                                            !state.email!.isPure
                                        ? "Please enter valid email id"
                                        : null,
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffDC1919),
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffD3D8DD),
                                      ),
                                    ),
                                    errorStyle: GoogleFonts.roboto(
                                        color: const Color(0xffDC1919)),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(
                                          config.AppConfig(context)
                                              .appWidth(4)),
                                      child: SvgPicture.asset(
                                        'assets/img/email.svg',
                                      ),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffD3D8DD),
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffD3D8DD),
                                      ),
                                    ),
                                  ),
                                ),*/



                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(3),
                                ),
                                InkWell(
                                  onTap: () {

                                    forgetPasswordCubit!. passwordForget(emailController.text);

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        config.AppConfig(context).appWidth(1),
                                        config.AppConfig(context).appHeight(3),
                                        config.AppConfig(context).appWidth(1),
                                        config.AppConfig(context).appHeight(3)),
                                    child: state.apiStatus!.isInProgress
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: config.AppColors()
                                                    .colorDark(1)),
                                          )
                                        : Container(
                                            height: config.AppConfig(context)
                                                .appHeight(6.5),
                                            width: config.AppConfig(context)
                                                .appWidth(100),
                                            decoration: BoxDecoration(
                                              gradient: state.email!.isValid
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
                                                'Forgot Password',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
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
