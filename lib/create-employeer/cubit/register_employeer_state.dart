part of 'register_employeer_cubit.dart';

@immutable
abstract class RegisterEmployeerState {}

class RegisterEmployeerInitial extends RegisterEmployeerState {}

class RegisteringEmployeer extends RegisterEmployeerState {}

class RegisterEmployeerError extends RegisterEmployeerState {
  final String error;

  RegisterEmployeerError({required this.error});
}

class EmployeerRegistered extends RegisterEmployeerState {}