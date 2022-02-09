import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-employeer/cubit/register_employeer_cubit.dart';
import 'package:gigandjob_web/create-employeer/data/repositories/register_employeer_repository.dart';
import 'package:gigandjob_web/create-employeer/data/request/register_employer_request.dart';
import 'package:gigandjob_web/create-employeer/presentation/widgets/create_employeer_form.dart';

class CreateEmployerScreen extends StatefulWidget {
  const CreateEmployerScreen({Key? key}) : super(key: key);

  @override
  _CreateEmployerScreenState createState() => _CreateEmployerScreenState();
}

class _CreateEmployerScreenState extends State<CreateEmployerScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<RegisterEmployeerCubit> (create: (context) =>
          RegisterEmployeerCubit(repository: RegisterEmployeerRepository(request: RegisterEmployerRequest()))
        ),
    ],
    child: Scaffold(
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
    )
    ,
    );
  }
}
