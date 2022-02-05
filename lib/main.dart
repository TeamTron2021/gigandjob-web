// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/constants.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login/login_view.dart';
import 'dashboard/dashboard_view.dart';
import 'package:flutter/services.dart';


void main() => runApp(
  RepositoryProvider<AdminRepository>(create: (context) => FakeAuthenticationRepository(),
  child: BlocProvider<AuthenticationBloc>(
    create: (context) {
      final adminRepo = RepositoryProvider.of<AdminRepository>(context);
      return AuthenticationBloc(adminRepo)..add(AppLoaded());
    },
    child: MyApp(),
    ),
  )
  
);

class MyApp extends StatelessWidget {
  const MyApp( {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor
      ),
      title: 'Git and Job Backoffice',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {

          if (state is AuthenticationAuthenticated) {
            return Dashboard(admin: state.admin);
          }
        
          return LoginView();
        },
      )
    );
  }
}