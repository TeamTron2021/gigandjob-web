// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/admin.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';

class Dashboard extends StatelessWidget {
  final AdminRepository admin;
  const Dashboard({Key? key, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              // Text(
              //   'Welcome, ${admin.}',
              //   style: TextStyle(
              //     fontSize: 24
              //   ),
              // ),
              const SizedBox(
                height: 12,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Logout'),
                onPressed: (){
                  // Add UserLoggedOut to authentication event stream.
                  authBloc.add(AdminLoggedOut());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}