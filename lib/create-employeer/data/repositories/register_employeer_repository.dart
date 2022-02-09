import 'package:gigandjob_web/create-employeer/data/models/employeer.dart';
import 'package:gigandjob_web/create-employeer/data/request/register_employer_request.dart';
import 'dart:convert';

class RegisterEmployeerRepository {
  final RegisterEmployerRequest request ;

  RegisterEmployeerRepository({required this.request});

  Future<int?> addEmployeer(Employeer employeer) async {
    final employeerObj = json.encode(
      {
        'companyName': employeer.companyName,
        'companyMail': employeer.companyMail,
        'rif': employeer.rif,
        'latitude': employeer.latitude,
        'longitude': employeer.longitude,
        'industry': employeer.industry,
      }
    );
    final employeerToSave = await request.addEmployeer(employeerObj);
    if(employeerToSave == null) return null;
    return employeerToSave;
  }
}