part of 'create_gig_cubit.dart';

@immutable
abstract class CreateGigState {}

class CreateGigInitial extends CreateGigState {}

class CreateGigError extends CreateGigState {
  final String error;

  CreateGigError(this.error);
}

class CreatingGig extends CreateGigState {}

class GigCreated extends CreateGigState {}
