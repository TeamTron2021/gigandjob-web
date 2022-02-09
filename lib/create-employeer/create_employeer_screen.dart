import 'package:flutter/material.dart';
import 'package:gigandjob_web/create-employeer/presentation/widgets/create_employeer_form.dart';

class CreateEmployerScreen extends StatefulWidget {
  const CreateEmployerScreen({Key? key}) : super(key: key);

  @override
  _CreateEmployerScreenState createState() => _CreateEmployerScreenState();
}

class _CreateEmployerScreenState extends State<CreateEmployerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Center(
                  child: Text(
                    'Create an Employer',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )),
              Divider(
                color: Colors.white,
              ),
              CreateEmployerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
