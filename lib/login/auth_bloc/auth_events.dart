import 'package:equatable/equatable.dart';
import 'package:gigandjob_web/login/admin_repo.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class AdminLoggedIn extends AuthenticationEvent {
  final String token;
  const AdminLoggedIn ({required this.token});

  @override
  List<Object> get props => [token];

}

class AdminLoggedOut extends AuthenticationEvent {}