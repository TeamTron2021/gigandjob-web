import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/admin_repo.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';
import 'package:gigandjob_web/login/login_bloc/login_event.dart';
import 'package:gigandjob_web/login/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthenticationBloc _authenticationBloc;
  final AdminRepository _adminRepository;

  LoginBloc({required AuthenticationBloc authenticationBloc, required AdminRepository adminRepository}) 
  :assert(authenticationBloc != null),
  assert(adminRepository != null),
  _authenticationBloc = authenticationBloc,
  _adminRepository = adminRepository,
  super(LoginInitial());


  Stream<LoginState> mapEventToState (LoginEvent event) async* {
    
    if (event is LoginSummitButtomPressed) {
      yield* _mapLoginSummitButtomPressed(event);
      
    }

  }

  Stream<LoginState> _mapLoginSummitButtomPressed(LoginSummitButtomPressed event) async* {
    yield LoginLoading();
    try {
      final token = await _adminRepository
      .authenticate(username: event.username, password: event.password);
      print(token);
      if (token == 'success') {
        _authenticationBloc.add(AdminLoggedIn(token: token));
      }  else {
        yield LoginFailure(error: "Algo inesperado ha pasado");
      }

    } catch (e) {
      yield LoginFailure(error: 'Algo muy malo paso');
    }
  }

  void setState(Null Function() param0) {}




}