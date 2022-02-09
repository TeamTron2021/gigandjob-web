import 'package:bloc/bloc.dart';
import 'package:gigandjob_web/create-employeer/data/models/employeer.dart';
import 'package:gigandjob_web/create-employeer/data/repositories/register_employeer_repository.dart';
import 'package:meta/meta.dart';

part 'register_employeer_state.dart';

class RegisterEmployeerCubit extends Cubit<RegisterEmployeerState> {
  final RegisterEmployeerRepository repository;
  RegisterEmployeerCubit({required this.repository}) : super(RegisterEmployeerInitial());

  void registerEmployeer(Employeer employeer) {
    emit(RegisteringEmployeer());
    repository.addEmployeer(employeer).then((employeer) {
      if(employeer != 201){
        emit(RegisterEmployeerError(error: 'Oops something went wrong'));
      }else{
        emit(EmployeerRegistered());
      }
    });
  }
}
