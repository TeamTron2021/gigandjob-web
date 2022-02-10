part of 'add_job_offer_cubit.dart';

@immutable
abstract class AddJobOfferState {}

class AddJobOfferInitial extends AddJobOfferState {}

class AddJobOfferError extends AddJobOfferState {
  final String error;
  AddJobOfferError({required this.error});
}

class AddingJobOffer extends AddJobOfferState {}
class JobOfferAdded extends AddJobOfferState {}