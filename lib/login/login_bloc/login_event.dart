import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

  const LoginEvent();

  @override 
  List<Object> get props => [];
}

class LoginSummitButtomPressed extends LoginEvent {

  final String username;
  final String password;

  const LoginSummitButtomPressed({required this.username, required this.password});

  @override 
  List<Object> get props => [username, password];

}