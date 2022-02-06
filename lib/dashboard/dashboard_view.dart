import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';

class Dashboard extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
   return Scaffold(
   backgroundColor: Colors.white,
   appBar: AppBar(title: const Text('Home'),),
body: Column(children: <Widget>[
Expanded(child: Center(child: Text('Home'),),),
Align(alignment: Alignment.bottomCenter,
child: RaisedButton(
child: Text('logout'),
onPressed: () {
   BlocProvider.of<AuthenticationBloc>(context).add(AdminLoggedOut());
},),)],
),);}
}