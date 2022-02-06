import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/login_bloc/login_event.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  final AdminRepository userRepository;

  const LoginPage({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            adminRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginSummitButtomPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          /// showing progress bar initially
          if (state is LoginLoading) {}
          return Row(children: [
            Container(
              child: _loginImage(context),
            ),
            const SizedBox(
              width: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Git and Job Backoffice Service.\n',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Username',
                              fillColor: Colors.black12,
                              filled: true,
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              fillColor: Colors.black12,
                              filled: true,
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              )),
                          controller: _passwordController,
                        ),
                        const SizedBox( height: 40),
                        ElevatedButton(
                          child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(child: Text('Sing In')),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            state is !LoginLoading ? _onLoginButtonPressed() : null;
                          }
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ]);
        },
      ),
    );
  }

  Widget _loginImage(context) {
    return Diagonal(
      clipHeight: 100.0,
      axis: Axis.vertical,
      position: DiagonalPosition.BOTTOM_RIGHT,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.8,
        height: MediaQuery.of(context).size.height,
        // color: Colors.blue,
        child: const Image(
          image: AssetImage('images/login-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
