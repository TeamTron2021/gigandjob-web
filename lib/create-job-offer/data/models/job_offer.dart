import 'package:gigandjob_web/create-job-offer/data/models/skill.dart';

class JobOffer {
  String description;
  int salary;
  List<Skill> skills;
  String title;
  int vacant;
  DateTime startDate;
  DateTime finalDate;

  JobOffer({required this.description, required this.salary, required this.skills, required this.title,required this.vacant,
      required this.startDate, required this.finalDate});

}
