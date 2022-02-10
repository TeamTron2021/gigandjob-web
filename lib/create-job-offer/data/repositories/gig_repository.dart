import 'dart:convert';

import 'package:gigandjob_web/create-job-offer/data/models/gig.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/gig_request.dart';

class GigRepository {
  final GigRequest request;

  GigRepository({required this.request});

  Future<int?> addGig(Gig gig, String employeerId) async {
    final gigObj = json.encode({
      'description':gig.description,
      'salary': gig.salary,
      'title':gig.title,
      'vacant':gig.vacant,
      'startDate': gig.startDate.toString(),
      'finalDate': gig.finalDate.toString(),
      'skills':gig.skills.map((e)=>{
        'skill':e.skill
      }).toList(),
      "time": gig.time,
      "amount": gig.amount,
    });
    final gigToSave = await request.createGig(gigObj, employeerId);
    if(gigToSave == null) return null;
    return gigToSave;
  }
}