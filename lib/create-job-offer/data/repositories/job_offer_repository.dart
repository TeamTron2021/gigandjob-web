import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:gigandjob_web/create-job-offer/data/models/job_offer.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/job_offer_request.dart';

class JobOfferRepository {
  final JobOfferRequest jobOfferRequest;

  JobOfferRepository({required this.jobOfferRequest});

  Future<int?> addJobOffer(JobOffer jobOffer, String employeerId) async {
    final jobOfferObj = json.encode({
      'description':jobOffer.description,
      'salary': jobOffer.salary,
      'title':jobOffer.title,
      'vacant':jobOffer.vacant,
      'startDate': jobOffer.startDate.toString(),
      'finalDate': jobOffer.finalDate.toString(),
      'skills':jobOffer.skills.map((e)=>{
        'skill':e.skill
      }).toList()
    });
    final jobOfferToSave = await jobOfferRequest.addJobOffer(jobOfferObj, employeerId);
    if(jobOfferToSave == null) return null;
    return jobOfferToSave;
  }
}