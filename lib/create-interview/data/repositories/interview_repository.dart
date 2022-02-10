import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:gigandjob_web/create-interview/data/models/interview.dart';
import 'package:gigandjob_web/create-interview/data/requests/interview_request.dart';

class InterviewRepository {
  final InterviewRequest interviewrRequest;

  InterviewRepository({required this.interviewRequest});

  Future<int?> addInterview(Interview interview, String postulationId) async {
    final interviewObj = json.encode({
      'title':interview.title,
      'description':interview.description,
      'date': interview.date.toString(),
    });
    final interviewToSave = await interviewRequest.addInterview(interviewObj, postulationId);
    if(interviewToSave == null) return null;
    return interviewToSave;
  }
}