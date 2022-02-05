import 'package:equatable/equatable.dart';
import 'package:gigandjob_web/login/admin_repo.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class AdminLoggedIn extends AuthenticationEvent {
  final AdminRepository admin;
  const AdminLoggedIn ({required this.admin});

  @override
  List<Object> get props => [admin];

}

class AdminLoggedOut extends AuthenticationEvent {}