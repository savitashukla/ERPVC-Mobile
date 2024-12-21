
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../repos/authentication_repository.dart';
import '../../../repos/user_repository.dart';
import '../cubit/login_cubit.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);



  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            return LoginCubit( authenticationRepository:
            context.read<AuthenticationRepository>(),
              userRepository: context.read<UserRepository>());
          },
          child: LoginPage()
        ),
    );
  }

 // GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: scaffoldKey,
      body: Container(
        child:
        BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) {
            return LoginView();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
