part of 'get_employeers_cubit.dart';

@immutable
abstract class GetEmployeersState {}

class GetEmployeersInitial extends GetEmployeersState {}

class FetchingEmployeers extends GetEmployeersState {}

class FetchingEmployeersError extends GetEmployeersState {
  final String error;

  FetchingEmployeersError({required this.error});
}

class EmployeersFetched extends GetEmployeersState {
  final List<EmployeerResponse> employeers;

  EmployeersFetched({required this.employeers});
}
