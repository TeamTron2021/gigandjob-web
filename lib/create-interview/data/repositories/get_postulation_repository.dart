import 'package:gigandjob_web/create-interview/data/models/postulation_response.dart';
import 'package:gigandjob_web/create-interview/data/requests/get_postulation_request.dart';

class GetPostulationRepository {
  final GetPostulationRequest request;

  GetPostulationRepository({required this.request});

  Future<List<PostulationResponse>> fetchPostulations() async {
    final postulationsRaw = await request.fetchPostulations();

    final postulationsToSend = postulationsRaw.map((e) => PostulationResponse.fromJson(e)).toList();
    return postulationsToSend;
  }

}