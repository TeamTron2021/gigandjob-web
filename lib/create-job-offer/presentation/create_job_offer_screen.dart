import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-job-offer/cubit/get_employeers_cubit.dart';
import 'package:gigandjob_web/create-job-offer/data/repositories/get_employer_repository.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/get_employeer_request.dart';
import 'package:gigandjob_web/create-job-offer/presentation/widgets/create_gig_form.dart';
import 'package:gigandjob_web/create-job-offer/presentation/widgets/create_job_offer_form.dart';

class CreateJobOfferScreen extends StatefulWidget {
  const CreateJobOfferScreen({Key? key}) : super(key: key);

  @override
  _CreateJobOfferScreenState createState() => _CreateJobOfferScreenState();
}

class _CreateJobOfferScreenState extends State<CreateJobOfferScreen> {
  bool _isJobOffer = true;
  void switchToGig(){
    setState(() {
      _isJobOffer = !_isJobOffer;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetEmployeersCubit>(
            create: (context) => GetEmployeersCubit(
                repository:
                    GetEmployeerRepository(request: GetEmployeerRequest()))),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Text(
                  _isJobOffer ? 'Create a job Offer' : 'Create a Gig',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
                const Divider(
                  color: Colors.white,
                ),
                Center(child: _isJobOffer ? const CreateJobOfferForm() : const CreateGigForm()),
                SizedBox(
                    height: 200,
                    width: 200,
                    child: FloatingActionButton(
                      onPressed: () {
                        switchToGig();
                      },
                      child: Text(_isJobOffer ? 'Switch to Gig' : 'Switch to Offer'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
