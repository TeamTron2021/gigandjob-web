import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/user-list/user_list_model.dart';
import 'package:gigandjob_web/user-list/user_list_repository.dart';

enum UserListCubitStateStatus { Idle, Invalid, InProgress, Success, Failure }

class UserListCubitState {
  List<UserModel> model;
  final UserListCubitStateStatus status;
  late Map<String, String> errors;

  UserListCubitState({
    required this.model,
  }) : status = UserListCubitStateStatus.Idle {
    errors = {};
  }

  UserListCubitState._(
      {required this.model, required this.status, required this.errors});

  invalid(Map<String, String> errors) => UserListCubitState._(
      model: model, status: UserListCubitStateStatus.Invalid, errors: errors);
  success() => UserListCubitState._(
      model: model, status: UserListCubitStateStatus.Success, errors: {});
  inProgress() => UserListCubitState._(
      model: model, status: UserListCubitStateStatus.InProgress, errors: {});
  failure() => UserListCubitState._(
      model: model, status: UserListCubitStateStatus.Failure, errors: {});
}

class UserListCubit extends Cubit<UserListCubitState> {
  UserListRepository repository;
  UserListCubit({required this.repository})
      : super(UserListCubitState(model: []));

  Future<void> getUsers() async {
    emit(UserListCubitState(model: await repository.getUsers()));
  }

  Future<void> suspendUser(UserModel model) async {
    await repository.suspend(model.id);
    model.status = "Supended";
    emit(UserListCubitState(
        model: state.model.map((m) {
      if (m.id == model.id)
        return model;
      else
        return m;
    }).toList()));
  }

  Future<void> reactivateUser(UserModel model) async {
    await repository.reactive(model.id);
    model.status = "Active";
    emit(UserListCubitState(
        model: state.model.map((m) {
      if (m.id == model.id)
        return model;
      else
        return m;
    }).toList()));
  }
}
