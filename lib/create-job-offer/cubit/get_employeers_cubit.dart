import 'package:bloc/bloc.dart';
import 'package:gigandjob_web/create-job-offer/data/models/employeer_response.dart';
import 'package:gigandjob_web/create-job-offer/data/repositories/get_employer_repository.dart';
import 'package:meta/meta.dart';

part 'get_employeers_state.dart';

class GetEmployeersCubit extends Cubit<GetEmployeersState> {
  final GetEmployeerRepository repository;

  GetEmployeersCubit({required this.repository}) : super(GetEmployeersInitial());

  void fetchEmployeers() {
    emit(FetchingEmployeers());
    repository.fetchEmployeers().then((employeers) {
      if(employeers.isNotEmpty) {
        emit(EmployeersFetched(employeers: employeers));
      }else {
        emit(FetchingEmployeersError(error: 'Oops something went wrong'));
      }
    });
  }
}
