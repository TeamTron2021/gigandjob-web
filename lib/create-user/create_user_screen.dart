import 'package:flutter/material.dart';
import 'package:gigandjob_web/create-user/create_user_form.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Center(
                  child: Text(
                'Create an User',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
              const Divider(
                color: Colors.white,
              ),
              CreateUserForm(),
            ],
          ),
        ),
      ),
    );
  }
}
