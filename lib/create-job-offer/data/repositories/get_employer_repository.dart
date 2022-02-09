import 'package:gigandjob_web/create-job-offer/data/models/employeer_response.dart';
import 'package:gigandjob_web/create-job-offer/data/requests/get_employeer_request.dart';

class GetEmployeerRepository {
  final GetEmployeerRequest request;

  GetEmployeerRepository({required this.request});

  Future<List<EmployeerResponse>> fetchEmployeers() async {
    final employeersRaw = await request.fetchEmployers();

    final employeersToSend = employeersRaw.map((e) => EmployeerResponse.fromJson(e)).toList();
    return employeersToSend;
  }

}