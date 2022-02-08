import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:gigandjob_web/create-job-offer/widgets/create_job_offer_form.dart';

class CreateJobOfferScreen extends StatefulWidget {
  const CreateJobOfferScreen({Key? key}) : super(key: key);

  @override
  _CreateJobOfferScreenState createState() => _CreateJobOfferScreenState();
}

class _CreateJobOfferScreenState extends State<CreateJobOfferScreen> {

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
              Center(child: CreateJobOfferForm()),
            ],
          ),
        ),
      ),
    );
  }
}
