import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-interview/cubit/get_postulations_cubit.dart';
import 'package:gigandjob_web/create-interview/data/repositories/get_postulation_repository.dart';
import 'package:gigandjob_web/create-interview/data/requests/get_postulation_request.dart';
import 'package:gigandjob_web/create-interview/presentation/widgets/create_interview_form.dart';

class CreateInterviewScreen extends StatefulWidget {
  const CreateInterviewScreen({Key? key}) : super(key: key);

  @override
  _CreateInterviewScreenState createState() => _CreateInterviewScreenState();
}

class _CreateInterviewScreenState extends State<CreateInterviewScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetPostulationsCubit>(
            create: (context) => GetPostulationsCubit(
                repository:
                    GetPostulationRepository(request: GetPostulationRequest()))),
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
                  'Create a job Offer',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
                Divider(
                  color: Colors.white,
                ),
                Center(child: CreateInterviewForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
