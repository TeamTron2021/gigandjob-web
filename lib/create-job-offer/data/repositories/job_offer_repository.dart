import 'dart:convert';

import 'package:gigandjob_web/create-job-offer/data/models/job_offer.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/job_offer_request.dart';

class JobOfferRepository {
  final JobOfferRequest jobOfferRequest;

  JobOfferRepository({required this.jobOfferRequest});

  Future<int?> addJobOffer(JobOffer jobOffer) async {
    final jobOfferObj = json.encode({
      'description':jobOffer.description,
      'salary': jobOffer.salary,
      'title':jobOffer.title,
      'vacant':jobOffer.vacant,
      'startDate':jobOffer.startDate,
      'finalDate':jobOffer.finalDate,
      'skills':jobOffer.skills.map((e)=>{
        'skill':e.skill
      }).toList()
    });

    final jobOfferToSave = await jobOfferRequest.addJobOffer(jobOfferObj);
    if(jobOfferToSave == null) return null;
    return jobOfferToSave;
  }
}