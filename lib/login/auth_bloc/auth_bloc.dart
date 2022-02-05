import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_events.dart';
import 'package:gigandjob_web/login/auth_bloc/auth_state.dart';

import '../admin_repo.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final AdminRepository _adminRepository;

  AuthenticationBloc(AdminRepository adminRepository) :
  assert (adminRepository != null), 
  _adminRepository = adminRepository,
  super(AuthenticationInitial());

  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is AdminLoggedIn) {
      yield* _mapAdminLoggedInToState(event);
    }

    if (event is AdminLoggedOut) {
      yield* _mapAdminLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final currentAdmin = await _adminRepository.authenticate(username: "", password: "");

      if (currentAdmin != null) {
        yield AuthenticationAuthenticated(admin: currentAdmin);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield const AuthenticationFailure(message: 'Ah ocurrido un error inesperado');
    }

  }

  Stream<AuthenticationState> _mapAdminLoggedInToState(AdminLoggedIn event) async* {
    yield AuthenticationAuthenticated(admin: event.admin);
  }

  Stream<AuthenticationState> _mapAdminLoggedOutToState(AdminLoggedOut event) async* {
    await _adminRepository.singOut();
    yield AuthenticationNotAuthenticated();
  }

  // @override
  // Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
  //   if (event is AppStarted) {
  //     final bool hasToken = await _adminRepository.hasToken();

  //     if (hasToken) {
  //       yield AuthenticationAuthenticated();
  //     } else {
  //       yield AuthenticationUnauthenticated();
  //     }
  //   }

  //   if (event is LoggedIn) {
  //     yield AuthenticationLoading();
  //     await _adminRepository.persistToken(event.token);
  //     yield AuthenticationAuthenticated();
  //   }

  //   if (event is LoggedOut) {
  //     yield AuthenticationLoading();
  //     await _adminRepository.deleteToken();
  //     yield AuthenticationUnauthenticated();
  //   }

  // }

}