import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-user/create_user_model.dart';
import 'package:gigandjob_web/create-user/create_user_repository.dart';

enum CreateUserCubitStateStatus { Idle, Invalid, InProgress, Success, Failure }

class CreateUserCubitState {
  final CreateUserModel model;
  final CreateUserCubitStateStatus status;
  late Map<String, String> errors;

  CreateUserCubitState({
    required this.model,
  }) : status = CreateUserCubitStateStatus.Idle {
    errors = {};
  }

  CreateUserCubitState._(
      {required this.model, required this.status, required this.errors});

  invalid(Map<String, String> errors) => CreateUserCubitState._(
      model: model, status: CreateUserCubitStateStatus.Invalid, errors: errors);
  success() => CreateUserCubitState._(
      model: model, status: CreateUserCubitStateStatus.Success, errors: {});
  inProgress() => CreateUserCubitState._(
      model: model, status: CreateUserCubitStateStatus.InProgress, errors: {});
  failure() => CreateUserCubitState._(
      model: model, status: CreateUserCubitStateStatus.Failure, errors: {});
}

class CreateUserCubit extends Cubit<CreateUserCubitState> {
  CreateUserRepository repository;
  CreateUserCubit({required this.repository})
      : super(CreateUserCubitState(model: CreateUserModel.empty()));

  save() async {
    if (state.status != CreateUserCubitStateStatus.Invalid ||
        state.status != CreateUserCubitStateStatus.InProgress) {
      emit(state.inProgress());
      await repository.save(state.model);
      emit(state.success());
    }
  }

  update({void Function(CreateUserModel model)? cb}) {
    if (cb != null) cb(state.model);
    Map<String, String> errors = {};
    final now = DateTime.now();

    if (state.model.firstname.trim().isEmpty) {
      errors["firstname"] = "The firstname cannot be empty";
    }
    if (state.model.lastname.trim().isEmpty) {
      errors["lastname"] = "The lastname cannot be empty";
    }
    if (state.model.email.trim().isEmpty) {
      errors["email"] = "The email cannot be empty";
    }
    if (state.model.password.trim().isEmpty) {
      errors["password"] = "The password cannot be empty";
    }
    if (state.model.password.length < 8) {
      errors["password"] = "The password cannot be less than 8 characters";
    }
    if (state.model.birthdate.isAfter(now) ||
        (state.model.birthdate.year == now.year &&
            state.model.birthdate.month == now.month &&
            state.model.birthdate.day == now.day)) {
      errors["birthdate"] = "The birthday cannot be after today";
    }

    emit(state.invalid(errors));
  }
}
