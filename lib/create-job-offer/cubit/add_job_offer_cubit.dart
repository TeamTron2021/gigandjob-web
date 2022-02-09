import 'package:bloc/bloc.dart';
import 'package:gigandjob_web/create-job-offer/data/models/job_offer.dart';
import 'package:gigandjob_web/create-job-offer/data/repositories/job_offer_repository.dart';
import 'package:meta/meta.dart';

part 'add_job_offer_state.dart';

class AddJobOfferCubit extends Cubit<AddJobOfferState> {
  final JobOfferRepository repository;
  AddJobOfferCubit({required this.repository}) : super(AddJobOfferInitial());

  void addJobOffer(JobOffer offer, String employeerId){
   emit(AddingJobOffer());
   repository.addJobOffer(offer, employeerId).then((offer) {
     if(offer != 201){
       emit(AddJobOfferError(error: 'Oops something went wrong'));
     }else{
       emit(JobOfferAdded());
     }

   });


  }
}
