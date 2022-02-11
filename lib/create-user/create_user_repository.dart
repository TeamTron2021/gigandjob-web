import 'package:gigandjob_web/create-user/create_user_model.dart';
import 'package:http/http.dart' as http;

abstract class CreateUserRepository {
  Future<void> save(CreateUserModel model);
}

class EndpointCreateUserRepository extends CreateUserRepository {
  final Uri uri;
  final http.Client httpClient;

  EndpointCreateUserRepository({required String url})
      : uri = Uri.parse(url),
        httpClient = http.Client();

  @override
  Future<void> save(CreateUserModel model) async {
    print(model);
    final response = await httpClient.post(uri, body: {
      "firstname": model.firstname,
      "lastname": model.lastname,
      "email": model.email,
      "birthday": model.birthdate.toString(),
      "password": model.password
    });

    print(response);
  }
}
