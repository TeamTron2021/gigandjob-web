import 'package:gigandjob_web/create-job-offer/data/models/skill.dart';

class Gig {
  String description;
  int salary;
  List<Skill> skills;
  String title;
  int vacant;
  DateTime startDate;
  DateTime finalDate;
  int amount;
  String time;

  Gig({required this.description, required this.salary, required this.skills, required this.title,required this.vacant,
    required this.startDate, required this.finalDate, required this.amount, required this.time});

}
