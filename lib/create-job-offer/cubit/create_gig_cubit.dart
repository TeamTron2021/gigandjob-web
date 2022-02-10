import 'package:bloc/bloc.dart';
import 'package:gigandjob_web/create-job-offer/data/models/gig.dart';
import 'package:gigandjob_web/create-job-offer/data/repositories/gig_repository.dart';
import 'package:meta/meta.dart';

part 'create_gig_state.dart';

class CreateGigCubit extends Cubit<CreateGigState> {
  final GigRepository repository;
  CreateGigCubit({required this.repository}) : super(CreateGigInitial());

  void createGig(Gig gig, String employeerId ) {
    emit(CreatingGig());
    repository.addGig(gig, employeerId).then((gig) {
      if(gig != 201){
        emit(CreateGigError('Oops something went wrong'));
      }else {
        emit(GigCreated());
      }
    });
  }
}
