
// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_state.dart';
import 'package:gigandjob_web/login/login_bloc/login_bloc.dart';
import 'package:gigandjob_web/login/login_bloc/login_event.dart';
import 'package:gigandjob_web/login/login_bloc/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key,}) :  super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: bgColor,
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);

            if (state is AuthenticationNotAuthenticated) {
              return const Body();
            }

            if (state is AuthenticationFailure) {
              // show error message
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text('Error'),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('Retry'),
                        onPressed: () {
                          authBloc.add(AppLoaded());
                        },
                      )
                    ],
                  ));
            }

            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );

          },
        ),
        )

    );
  } 
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final adminRepo = RepositoryProvider.of<AdminRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Row(
      children:[
      
      Container(
        child: _loginImage(context),
      ),
      const SizedBox(width: 100,),
      
      Column(children: [
        const Text('Git and Job Backoffice Service.\n', 
        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
        const SizedBox(height:30),
        Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocProvider(create: (context) => LoginBloc(authenticationBloc: authBloc, adminRepository: adminRepo),
          child: _SingInForm(),
          ),
          )
      ),
      ],)
   

      ]
    );


  }
   Widget _loginForm() {
    return Form(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        _usernameTextField(),
        const SizedBox(height:30),
        _passwordTextField(),
        const SizedBox(height: 40,),
        _summitButton(),
      ],
      )
    );
  }

  Widget _usernameTextField() {
    return const TextField(
          decoration: InputDecoration(
            hintText: 'Username',
            fillColor: Colors.black12,
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)
            )
          ),
        );
  }

  Widget _passwordTextField() {
    return const TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            fillColor: Colors.black12,
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)
            )
          ),
        );
  }

  Widget _summitButton() {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 20,
                blurRadius: 20,
              )
            ]
          ),
          child: ElevatedButton(
            child: const SizedBox (
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Sing In')),
              ),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ), onPressed: () {  },
          ),
          );
  }

Widget _loginImage(context) {
  return Diagonal(
  clipHeight:100.0,
  axis: Axis.vertical,
  
  position: DiagonalPosition.BOTTOM_RIGHT,
    child: SizedBox(
      width: MediaQuery.of(context).size.width /1.8,
      height: MediaQuery.of(context).size.height,
     // color: Colors.blue,
      child: Image.network(
        "https://group.schindler.com/content/dam/website/global/images/careers/schindler-working-at-schindler-41.jpg", 
        fit: BoxFit.cover,
        ),
    ),
  );
}

}

class _SingInForm extends StatefulWidget {
 
  @override
  __SingInFormState createState() => __SingInFormState();
}

class __SingInFormState extends State<_SingInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLogginButtomPressed () {
      if (_key.currentState!.validate()) {
        _loginBloc.add(LoginSummitButtomPressed(username: _usernameController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
    return BlocListener<LoginBloc, LoginState>
      (listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child:Form (
            key: _key,
            //autovalidate: _autoValidate,
            child: Column(
              children: <Widget> [
                TextFormField(
                    decoration: const InputDecoration(
                    hintText: 'Username',
                    fillColor: Colors.black12,
                    filled: true,
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    )
                  ),
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null) {
                      return 'Username es requerdo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:30),
                TextFormField(
                    decoration: const InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.black12,
                    filled: true,
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    )
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null) {
                      return 'Password es requerdo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:40),
                Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 20,
                blurRadius: 20,
              )
            ]
          ),
          child: ElevatedButton(
            child: const SizedBox (
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Sing In')),
              ),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ), onPressed: _onLogginButtomPressed(),
          ),
          ),
              ],
            ),
          )
      );
    
  } 

   void _showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      )
    );
  }

}
