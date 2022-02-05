import 'package:equatable/equatable.dart';

import '../admin_repo.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override 
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {

  final AdminRepository admin;

  const AuthenticationAuthenticated({required this.admin});

  @override
  List<Object> get props => [admin];

}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}