import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_request.dart';

class Admin extends AdminRepository {


  final String username;
  final String password;

  Admin(this.username, this.password) : super();

}