// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/constants.dart';
import 'package:gigandjob_web/create-job-offer/cubit/add_job_offer_cubit.dart';
import 'package:gigandjob_web/create-job-offer/data/repositories/job_offer_repository.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/job_offer_request.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_state.dart';
import 'package:gigandjob_web/login/auth_request.dart';
import 'package:gigandjob_web/login/login_bloc/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard/dashboard_view.dart';
import 'package:flutter/services.dart';


void main() {
  final adminRepository = AdminRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(adminRepository)..add(AppLoaded());
    },
    child: MyApp(adminRepo: adminRepository,),)
    
  );
}

class MyApp extends StatelessWidget {

final AdminRepository adminRepo;
  const MyApp( {Key? key, required this.adminRepo, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddJobOfferCubit>(create: (context) => AddJobOfferCubit(repository: JobOfferRepository(jobOfferRequest: JobOfferRequest())))
      ],
      child: MaterialApp(
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
            print(state);
            if (state is AuthenticationAuthenticated) {
              return Dashboard(title:'test' ,);
            }
            if(state is AuthenticationLoading){
              return CircularProgressIndicator();
            }
          
            return LoginPage(userRepository: adminRepo,);
          },
        )
      ),
    );
  }
}

// class SplashPage extends StatelessWidget {
//    @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//    body: Center(
//    child: Text('Splash Screen'),
//    ),
// );}
// }